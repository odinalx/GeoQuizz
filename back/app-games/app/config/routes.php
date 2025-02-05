<?php

use Slim\App;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use geoquizz\application\actions\HomeAction;
use geoquizz\application\actions\CreateGameAction;
use geoquizz\application\actions\GetGameAction;
use geoquizz\application\actions\StartGameAction;

return function(App $app): App {

    // Public routes
    $app->get('/', HomeAction::class)->setName('home');


    $app->post('/games', CreateGameAction::class)->setName('createGame');
    $app->get('/games/{id}', GetGameAction::class)->setName('getGame');
    $app->patch('/games/{id}/start', StartGameAction::class)->setName('startGame');
                                                            
    $app->options('/{routes:.+}', function (Request $request, Response $response) {
        return $response;
    });

    return $app;
};