<?php

namespace geoquizz\core\repositoryInterfaces;

use geoquizz\core\domain\entities\games\Game;
use geoquizz\core\dto\GameDTO;

interface GameRepositoryInterface
{   
    public function save(Game $game): GameDTO;
    public function getGame(string $id): GameDTO;
    public function startGame(string $id): GameDTO;
    public function finishGame(string $id): GameDTO;
}