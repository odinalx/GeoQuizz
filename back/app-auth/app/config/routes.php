<?php

use Slim\App;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use geoquizz\application\actions\HomeAction;
use geoquizz\application\actions\RegisterAction;
use geoquizz\application\actions\LoginAction;
use geoquizz\application\actions\RefreshAction;
use geoquizz\application\actions\ValidateTokenAction;

return function(App $app): App {

    // Public routes
    $app->get('/', HomeAction::class)->setName('home');

    //Authentification
    $app->post('/auth/register', RegisterAction::class)->setName('register');
    $app->post('/auth/login', LoginAction::class)->setName('login');
    $app->post('/auth/refresh', RefreshAction::class)->setName('refresh');
    $app->post('/tokens/validate', ValidateTokenAction::class);
                                                            
    $app->options('/{routes:.+}', function (Request $request, Response $response) {
        return $response;
    });

    return $app;
};