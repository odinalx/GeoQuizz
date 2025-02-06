<?php

use Psr\Container\ContainerInterface;
use geoquizz\core\repositoryInterfaces\GameRepositoryInterface;
use geoquizz\core\services\games\ServiceGameInterface;
use geoquizz\infrastructure\PDO\PdoGameRepository;
use geoquizz\core\services\games\ServiceGame;
use geoquizz\core\repositoryInterfaces\PhotosRepositoryInterface;
use geoquizz\infrastructure\adapter\PhotosRepositoryAdapter;
use GuzzleHttp\Client;
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

    PhotosRepositoryInterface::class => function (ContainerInterface $container) {
        $client = $container->get('directusClient');
        return new PhotosRepositoryAdapter($client);
    },

    GameRepositoryInterface::class => function (ContainerInterface $container) {
        $pdo = $container->get('games.pdo');
        return new PdoGameRepository($pdo);
    },

    ServiceGameInterface::class => function (ContainerInterface $container) {
        $gameRepository = $container->get(GameRepositoryInterface::class);
        $photosRepository = $container->get(PhotosRepositoryInterface::class);
        return new ServiceGame($gameRepository, $photosRepository);
    },
    
];

   