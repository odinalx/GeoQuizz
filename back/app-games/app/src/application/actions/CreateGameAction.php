<?php

namespace geoquizz\application\actions;

use geoquizz\core\services\games\ServiceGameInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;
use geoquizz\core\dto\InputGameDTO;
use geoquizz\core\services\games\ServiceCreationErrorException;

class CreateGameAction extends AbstractAction
{
    private ServiceGameInterface $serviceGame;

    public function __construct(ServiceGameInterface $serviceGame)
    {
        $this->serviceGame = $serviceGame;
    }

    public function __invoke(ServerRequestInterface $rq, ResponseInterface $rs, array $args): ResponseInterface
    {
        try {
            $data = json_decode($rq->getBody()->getContents(), true);

            if (!isset($data['creatorId']) || !isset($data['serieId'])) {
                return $this->respondWithError($rs, 'Paramètres manquants', 400);
            }

            $inputGame = new InputGameDTO(
                $data['creatorId'],
                $data['serieId']
            );

            $gameDTO = $this->serviceGame->createGame($inputGame);
            $jwt = $this->serviceGame->createGameToken($gameDTO->id);

            $responseData = [
                'success' => true,
                'data' => [
                    'self' => '/games/' . $gameDTO->id,
                    'game_id' => $gameDTO->id,
                    'status' => $gameDTO->status,
                    'gameToken' => $jwt,
                ],
            ];

            $rs->getBody()->write(json_encode($responseData));
            return $rs->withHeader('Content-Type', 'application/json')->withStatus(201);
        } catch (ServiceCreationErrorException $e) {
            return $this->respondWithError($rs, $e->getMessage(), 500);
        } catch (\Exception $e) {
            return $this->respondWithError($rs, $e->getMessage(), 500);
        }
    }

    private function respondWithError(ResponseInterface $response, string $message, int $status): ResponseInterface
    {
        $responseData = ['error' => $message];
        $response->getBody()->write(json_encode($responseData));
        return $response->withHeader('Content-Type', 'application/json')->withStatus($status);
    }
}
