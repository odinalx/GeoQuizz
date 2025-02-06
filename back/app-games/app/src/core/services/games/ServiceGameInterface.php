<?php
namespace geoquizz\core\services\games;

use geoquizz\core\dto\InputGameDTO;
use geoquizz\core\dto\GameDTO;

interface ServiceGameInterface
{
    public function createGame(InputGameDTO $g): GameDTO;
    public function getGame(string $id): GameDTO;
    public function startGame(string $id): GameDTO;
    public function finishGame(string $id): GameDTO;
}