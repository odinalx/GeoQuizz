<?php

namespace app\middlewares;

use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use app\providers\JWTManager;

class GameTokenMiddleware
{

    public function __invoke(ServerRequestInterface $request, RequestHandler $handler): ResponseInterface
    {
        $token = $request->getHeaderLine('X-Game-Token');

        if (!$token) {
            return $this->respondWithError('Token de partie manquant', 401);
        }

        try {
            $jwtmanager = new JWTManager();
            $jwtmanager->decodeToken($token); // "valide" le token 

            return $handler->handle($request);
        } catch (\Exception $e) {
            return $this->respondWithError($e->getMessage(), 401);
        }

        return $handler->handle($request);
    }

    private function respondWithError(string $message, int $status): ResponseInterface
    {   
        $response = new \Slim\Psr7\Response();
        $response->getBody()->write(json_encode(['error' => $message]));
        return $response->withHeader('Content-Type', 'application/json')->withStatus($status);
    }
}
