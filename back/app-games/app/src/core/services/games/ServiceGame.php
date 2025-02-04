<?php

namespace geoquizz\core\services\games;

use geoquizz\core\domain\entities\games\Game;
use geoquizz\core\dto\InputGameDTO;
use geoquizz\core\dto\GameDTO;
use geoquizz\core\repositoryInterfaces\GameRepositoryInterface;
use geoquizz\core\services\games\ServiceCreationErrorException;
use geoquizz\infrastructure\PDO\RepositoryCreationErrorException;
use geoquizz\infrastructure\PDO\RepositoryNotFoundException;
use geoquizz\infrastructure\PDO\StatusException;

class ServiceGame implements ServiceGameInterface
{
    private GameRepositoryInterface $gameRepository;

    public function __construct(GameRepositoryInterface $gameRepository)
    {
        $this->gameRepository = $gameRepository;
    }

    public function createGame(InputGameDTO $g): GameDTO
    {
        try {
            $game = new Game($g->creatorId, $g->serieId);
            return $this->gameRepository->save($game);
        } catch (RepositoryCreationErrorException $e) {
            throw new ServiceCreationErrorException($e->getMessage());
        }
    }

    public function getGame(string $id): GameDTO
    {
        try {
            return $this->gameRepository->getGame($id);
        } catch (RepositoryNotFoundException $e) {
            throw new ServiceNotFoundException($e->getMessage());
        }
    }

    public function startGame(string $id): GameDTO
    {
        try {
            return $this->gameRepository->startGame($id);
        } catch (RepositoryNotFoundException $e) {
            throw new ServiceNotFoundException($e->getMessage());
        } catch (StatusException $e) {
            throw new \Exception($e->getMessage());
        }
    }
}
