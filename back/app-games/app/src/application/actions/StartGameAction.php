<?php
namespace geoquizz\application\actions;

use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;
use geoquizz\core\services\games\ServiceGameInterface;
use geoquizz\core\services\games\ServiceNotFoundException;

class StartGameAction extends AbstractAction {

    private ServiceGameInterface $serviceGame;

    public function __construct(ServiceGameInterface $serviceGame)
    {
        $this->serviceGame = $serviceGame;
    }

    public function __invoke(ServerRequestInterface $rq, ResponseInterface $rs, array $args): ResponseInterface {
        try {
            $gameDTO = $this->serviceGame->startGame($args['id']);

            $responseData = [
                'success' => true,
                'data' => [
                    'game_id' => $gameDTO->id,
                    'status' => $gameDTO->status,
                    'score' => $gameDTO->score,
                    'creator_id' => $gameDTO->creatorId,
                    'serie_id' => $gameDTO->serieId,
                    'created_at' => $gameDTO->created_at->format('d-m-Y H:i'),
                ],
            ];

            $rs->getBody()->write(json_encode($responseData));
            return $rs->withHeader('Content-Type', 'application/json')->withStatus(200);
        } catch (ServiceNotFoundException $e) {
            return $this->respondWithError($rs, $e->getMessage(), 404);
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