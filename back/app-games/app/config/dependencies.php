<?php

use Psr\Container\ContainerInterface;
use geoquizz\core\repositoryInterfaces\GameRepositoryInterface;
use geoquizz\core\services\games\ServiceGameInterface;
use geoquizz\infrastructure\PDO\PdoGameRepository;
use geoquizz\core\services\games\ServiceGame;
use geoquizz\core\repositoryInterfaces\PhotosRepositoryInterface;
use geoquizz\infrastructure\adapter\PhotosRepositoryAdapter;
use GuzzleHttp\Client;
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

return [
    
    'games.pdo' => function (ContainerInterface $container) {
        $configPath = $container->get('games.db.config'); // Récupère le chemin défini dans settings.php
        $config = parse_ini_file($configPath);
        $dsn = "{$config['driver']}:host={$config['host']};dbname={$config['database']}";
        $user = $config['username'];
        $password = $config['password'];
        return new \PDO($dsn, $user, $password, [\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION]);
    },

    'directusClient' => function () {
        return new Client([
            'base_uri' => 'http://api.directus:8055/',
            'timeout'  => 1000.0,
        ]);
    },

    'rabbitmq' => function(ContainerInterface $container){
        $exchange_name = 'jeux';
        $queue_name = 'jeux_notifications';
        $routing_key = 'routing';
        $connection = new AMQPStreamConnection('rabbitmq', 5672, 'admin', 'admin');
        $channel = $connection->channel();
        $channel->exchange_declare($exchange_name, 'direct', false, true, false);
        $channel->queue_declare($queue_name, false, true, false, false);
        $channel->queue_bind($queue_name, $exchange_name, $routing_key);
        return $connection; 
    },



    PhotosRepositoryInterface::class => function (ContainerInterface $container) {
        $client = $container->get('directusClient');
        return new PhotosRepositoryAdapter($client);
    },

    GameRepositoryInterface::class => function (ContainerInterface $container) {
        $pdo = $container->get('games.pdo');
        $rabbitmq=$container->get('rabbitmq');
        return new PdoGameRepository($pdo, $rabbitmq);
    },

    ServiceGameInterface::class => function (ContainerInterface $container) {
        $gameRepository = $container->get(GameRepositoryInterface::class);
        $photosRepository = $container->get(PhotosRepositoryInterface::class);
        $rabbitmq=$container->get('rabbitmq');
        return new ServiceGame($gameRepository, $photosRepository, $rabbitmq);
    },
    
];

   