<?php

namespace gateway\application\actions;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use GuzzleHttp\ClientInterface;
use GuzzleHttp\Exception\BadResponseException;
use GuzzleHttp\Exception\ClientException;
use GuzzleHttp\Exception\ServerException;
use Slim\Exception\HttpNotFoundException;

class GenericAction extends AbstractAction
{
    private ClientInterface $authClient;
    private ClientInterface $gameClient;
    private ClientInterface $directusClient;

    public function __construct(ClientInterface $authClient, ClientInterface $gameClient, ClientInterface $directusClient)
    {
        $this->authClient = $authClient;
        $this->gameClient = $gameClient;
        $this->directusClient = $directusClient;
    }

    public function __invoke(ServerRequestInterface $rq, ResponseInterface $rs, array $args): ResponseInterface
    {
        $method = $rq->getMethod();
        $path = $rq->getUri()->getPath();
        $body = $rq->getBody()->getContents();

        // Déterminer le client à utiliser en fonction du path
        if (strpos($path, '/auth') === 0) {
            $client = $this->authClient;
        } elseif (strpos($path, '/games') === 0) {
            $client = $this->gameClient;
        } else if (strpos($path, '/items') === 0) {
            $client = $this->directusClient;
        } else {
            throw new HttpNotFoundException($rq, 'Route not found');
        }

        try {
            $response = $client->request($method, $path, [
                'body' => $body,
                'headers' => $rq->getHeaders()
            ]);

            $rs->getBody()->write($response->getBody()->getContents());
            return $rs->withHeader('Content-Type', 'application/json')
                ->withStatus($response->getStatusCode());
        } catch (ClientException | ServerException $e) {
            return $this->handleClientException($rs, $e);
        } catch (\Exception $e) {
            return $this->respondWithError($rs, "Erreur interne du serveur : " . $e->getMessage(), 500);
        }
    }

    private function handleClientException(ResponseInterface $rs, BadResponseException $e): ResponseInterface
    {
        $statusCode = $e->getResponse()->getStatusCode();
        $errorBody = $e->getResponse()->getBody()->getContents();
        $errorData = json_decode($errorBody, true);

        // Récupérer le message d'erreur envoyé par le microservice
        $errorMessage = $errorData['error'] ?? 'Une erreur inconnue est survenue.';

        switch ($statusCode) {
            case 400:
                return $this->respondWithError($rs, "Requête invalide : $errorMessage", 400);
            case 401:
                return $this->respondWithError($rs, "Accès non autorisé : $errorMessage", 401);
            case 403:
                return $this->respondWithError($rs, "Accès interdit : $errorMessage", 403);
            case 404:
                return $this->respondWithError($rs, "Ressource non trouvée : $errorMessage", 404);
            case 409:
                return $this->respondWithError($rs, "Conflit : $errorMessage", 409);
            case 500:
                return $this->respondWithError($rs, "Erreur interne du serveur : $errorMessage", 500);
            default:
                return $this->respondWithError($rs, "Erreur inconnue.", $statusCode);
        }
    }

    private function respondWithError(ResponseInterface $response, string $message, int $status): ResponseInterface
    {
        $responseData = [
            'status' => $status,
            'error' => $message
        ];

        $response->getBody()->write(json_encode($responseData, JSON_PRETTY_PRINT));
        return $response->withHeader('Content-Type', 'application/json')->withStatus($status);
    }
}
