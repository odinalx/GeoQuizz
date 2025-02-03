<?php
use Psr\Container\ContainerInterface;
use GuzzleHttp\Client;
use gateway\application\actions\GenericAction;
use app\middlewares\auth\AuthMiddleware;
return [
    

    'authClient' => function () {
        return new Client([
            'base_uri' => 'http://api.auth:80/',
            'timeout'  => 1000.0,
        ]);
    },

    GenericAction::class => function(ContainerInterface $container) {
        $authClient = $container->get('authClient');
        return new GenericAction($authClient);
    },

    AuthMiddleware::class => function(ContainerInterface $container) {
        return new AuthMiddleware($container->get('authClient'));
    },

];
