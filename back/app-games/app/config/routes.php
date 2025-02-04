<?php

use Slim\App;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use geoquizz\application\actions\HomeAction;
use geoquizz\application\actions\CreateGameAction;

return function(App $app): App {

    // Public routes
    $app->get('/', HomeAction::class)->setName('home');


    $app->post('/games', CreateGameAction::class)->setName('createGame');
                                                            
    $app->options('/{routes:.+}', function (Request $request, Response $response) {
        return $response;
    });

    return $app;
};