<?php

namespace geoquizz\core\services\auth;

use geoquizz\core\dto\AuthDTO;
use geoquizz\core\dto\CredentialsDTO;

interface ServiceAuthInterface
{   
    public function register(CredentialsDTO $credentials, int $role): void; // Methode pour enregistrer un utilisateur
    public function login(CredentialsDTO $credentials): AuthDTO; // Methode pour authentifier un utilisateur
    public function refresh(string $refreshToken): AuthDTO; // Methode pour rafraichir un token
}