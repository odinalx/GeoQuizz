<?php

use Psr\Container\ContainerInterface;
use geoquizz\core\repositoryInterfaces\GameRepositoryInterface;
use geoquizz\core\services\games\ServiceGameInterface;
use geoquizz\infrastructure\PDO\PdoGameRepository;
use geoquizz\core\services\games\ServiceGame;
return [
    
    'games.pdo' => function (ContainerInterface $container) {
        $configPath = $container->get('games.db.config'); // Récupère le chemin défini dans settings.php
        $config = parse_ini_file($configPath);
        $dsn = "{$config['driver']}:host={$config['host']};dbname={$config['database']}";
        $user = $config['username'];
        $password = $config['password'];
        return new \PDO($dsn, $user, $password, [\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION]);
    },

    ServiceGameInterface::class => function (ContainerInterface $container) {
        $gameRepository = $container->get(GameRepositoryInterface::class);
        return new ServiceGame($gameRepository);
    },

    GameRepositoryInterface::class => function (ContainerInterface $container) {
        $pdo = $container->get('games.pdo');
        return new PdoGameRepository($pdo);
    },

];

   