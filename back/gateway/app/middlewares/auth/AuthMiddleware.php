<?php

namespace app\middlewares\auth;

use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use GuzzleHttp\ClientInterface;
use GuzzleHttp\Exception\RequestException;
use Slim\Exception\HttpUnauthorizedException;
use Slim\Exception\HttpBadRequestException;
use Slim\Psr7\Response;

class AuthMiddleware implements MiddlewareInterface
{
    private ClientInterface $authClient;

    public function __construct(ClientInterface $authClient) {
        $this->authClient = $authClient;
    }

    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): Response {
        $authHeader = $request->getHeaderLine('Authorization');

        // Vérifie si le token est manquant ou mal formé
        if (!$authHeader || !preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
            throw new HttpUnauthorizedException($request, 'Token manquant ou invalide');
        }

        $token = $matches[1];

        try {
            $authResponse = $this->authClient->request('POST', '/tokens/validate', [
                'headers' => ['Authorization' => "Bearer $token"]
            ]);

            return $handler->handle($request);

        } catch (RequestException $e) {
            $statusCode = $e->getResponse() ? $e->getResponse()->getStatusCode() : 500;

            if ($statusCode === 400) {
                throw new HttpBadRequestException($request, 'Requête invalide vers le service d\'authentification');
            } elseif ($statusCode === 401) {
                throw new HttpUnauthorizedException($request, 'Token invalide ou expiré');
            } else {
                throw new \RuntimeException('Erreur lors de la validation du token');
            }
        }
    }
}
