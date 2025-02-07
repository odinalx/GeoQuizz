<?php

use Slim\App;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use geoquizz\application\actions\HomeAction;
use geoquizz\application\actions\CreateGameAction;
use geoquizz\application\actions\GetGameAction;
use geoquizz\application\actions\StartGameAction;
use geoquizz\application\actions\FinishGameAction;
use geoquizz\application\actions\PlayAction;
use app\middlewares\GameTokenMiddleware;

return function(App $app): App {

    // Public routes
    $app->get('/', HomeAction::class)->setName('home');


    $app->post('/games', CreateGameAction::class)->setName('createGame');

    $app->group('/games/{id}', function ($group) {
        $group->get('', GetGameAction::class)->setName('getGame');
        $group->patch('/start', StartGameAction::class)->setName('startGame');
        $group->patch('/finish', FinishGameAction::class)->setName('finishGame');
        $group->post('/play', PlayAction::class)->setName('play');
    })->add(GameTokenMiddleware::class);
                                                            
    $app->options('/{routes:.+}', function (Request $request, Response $response) {
        return $response;
    });

    return $app;
};