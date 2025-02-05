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

    'gameClient' => function () {
        return new Client([
            'base_uri' => 'http://api.games:80/',
            'timeout'  => 1000.0,
        ]);
    },

    'directusClient' => function () {
        return new Client([
            'base_uri' => 'http://api.directus:8055/',
            'timeout'  => 1000.0,
        ]);
    },

    GenericAction::class => function(ContainerInterface $container) {
        $authClient = $container->get('authClient');
        $gameClient = $container->get('gameClient');
        $directusClient = $container->get('directusClient');
        return new GenericAction($authClient, $gameClient, $directusClient);
    },

    AuthMiddleware::class => function(ContainerInterface $container) {
        return new AuthMiddleware($container->get('authClient'));
    },

];
