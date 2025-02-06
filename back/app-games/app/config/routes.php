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

return function(App $app): App {

    // Public routes
    $app->get('/', HomeAction::class)->setName('home');


    $app->post('/games', CreateGameAction::class)->setName('createGame');
    $app->get('/games/{id}', GetGameAction::class)->setName('getGame');
    $app->patch('/games/{id}/start', StartGameAction::class)->setName('startGame');
    $app->patch('/games/{id}/finish', FinishGameAction::class)->setName('finishGame');
    $app->post('/games/{id}/play', PlayAction::class)->setName('play');
                                                            
    $app->options('/{routes:.+}', function (Request $request, Response $response) {
        return $response;
    });

    return $app;
};