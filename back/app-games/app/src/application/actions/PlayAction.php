<?php

namespace geoquizz\application\actions;

use geoquizz\core\services\games\ServiceGameInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

class PlayAction extends AbstractAction
{
    private ServiceGameInterface $serviceGame;

    public function __construct(ServiceGameInterface $serviceGame,  AMQPStreamConnection $amqpConnection)
    {
        $this->serviceGame = $serviceGame;
    }

    public function __invoke(ServerRequestInterface $rq, ResponseInterface $rs, array $args): ResponseInterface
    {
        $gameid = $args['id'];

        $data = json_decode($rq->getBody()->getContents(), true);

        if (!isset($data['photoid']) || !isset($data['lat']) || !isset($data['long']) || !isset($data['time'])) {
            return $this->respondWithError($rs, 'Paramètres manquants', 400);
        }        

        $photoid = $data['photoid'];
        $lat = $data['lat'];
        $long = $data['long'];
        $time = $data['time'];

        $gameDTO = $this->serviceGame->play($gameid, $photoid, $lat, $long, $time);

        $responseData = [
            'success' => true,
            'data' => [
                'self' => '/games/' . $gameDTO->id,
                'game_id' => $gameDTO->id,
                'newScore' => $gameDTO->score,
            ],
        ];

        $rs->getBody()->write(json_encode($responseData));
        return $rs->withHeader('Content-Type', 'application/json')->withStatus(200);
    }

    private function respondWithError(ResponseInterface $response, string $message, int $status): ResponseInterface
    {
        $responseData = ['error' => $message];
        $response->getBody()->write(json_encode($responseData));
        return $response->withHeader('Content-Type', 'application/json')->withStatus($status);
    }
}
