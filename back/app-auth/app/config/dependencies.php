<?php
use geoquizz\core\services\auth\ServiceAuth;
use Psr\Container\ContainerInterface;
use geoquizz\core\services\auth\ServiceAuthInterface;
use geoquizz\core\repositoryInterfaces\AuthRepositoryInterface;
use geoquizz\infrastructure\PDO\PdoAuthRepository;
use app\providers\JWTManager;
return [
    
    'auth.pdo' => function (ContainerInterface $container) {
        $configPath = $container->get('auth.db.config'); // Récupère le chemin défini dans settings.php
        $config = parse_ini_file($configPath);
        $dsn = "{$config['driver']}:host={$config['host']};dbname={$config['database']}";
        $user = $config['username'];
        $password = $config['password'];
        return new \PDO($dsn, $user, $password, [\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION]);
    },

    AuthRepositoryInterface::class => function (ContainerInterface $container) {
        $pdo = $container->get('auth.pdo');
        return new PdoAuthRepository($pdo);
    },

    ServiceAuthInterface::class => function (ContainerInterface $container) {
        $authRepository = $container->get(AuthRepositoryInterface::class);
        $jwtManager = $container->get(JWTManager::class);
        return new ServiceAuth($authRepository, $jwtManager);
    },

];

   