<?php
namespace geoquizz\infrastructure\PDO;

use PDO;
use PDOException;
use geoquizz\core\repositoryInterfaces\GameRepositoryInterface;
use geoquizz\core\domain\entities\games\Game;
use geoquizz\core\dto\GameDTO;
use geoquizz\infrastructure\PDO\RepositoryCreationErrorException;
use geoquizz\infrastructure\PDO\RepositoryNotFoundException;

class PdoGameRepository implements GameRepositoryInterface {

    private PDO $pdo;
    
    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function save(Game $game): GameDTO {
        try {
            $stmt = $this->pdo->prepare('INSERT INTO games (id, creator_id, serie_id, status, score, created_at ) VALUES (:id, :creator_id, :serie_id, :status, :score, :created_at)');
            $stmt->execute([
                'id' => $game->getID(),
                'creator_id' => $game->creatorId,
                'serie_id' => $game->serieId,
                'status' => $game->status,
                'score' => $game->score,
                'created_at' => $game->created_at->format('d-m-Y H:i')
            ]);
            
            return new GameDTO($game);
        } catch (PDOException $e) {
            throw new RepositoryCreationErrorException("Impossible de créer une partie : " . $e->getMessage());
        }
    }

    public function getGame(string $id): GameDTO {
        try {
            $stmt = $this->pdo->prepare('SELECT * FROM games WHERE id = :id');
            $stmt->execute(['id' => $id]);
            $game = $stmt->fetch();
            if ($game) {
                $newgame = new Game($game['creator_id'], $game['serie_id']);
                $newgame->setID($game['id']);
                $newgame->setStatus($game['status']);
                $newgame->setScore($game['score']);
                $newgame->setCreatedAt(new \DateTimeImmutable($game['created_at']));
                return new GameDTO($newgame);
            } else {
                return null;
            }
        } catch (PDOException $e) {
            throw new RepositoryNotFoundException("Impossible de récupérer la partie : " . $e->getMessage());
        }
    }

    public function startGame(string $id): GameDTO
{
    try {
        $stmt = $this->pdo->prepare('SELECT status FROM games WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $game = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$game) {
            throw new RepositoryNotFoundException("Partie introuvable.");
        }

        if ($game['status'] === Game::STATUS_STARTED) {
            throw new StatusException("La partie a déjà été démarrée.");
        }
        if ($game['status'] === Game::STATUS_FINISHED) {
            throw new StatusException("La partie est déjà terminée.");
        }

        $stmt = $this->pdo->prepare('UPDATE games SET status = :status WHERE id = :id');
        $stmt->execute([
            'id' => $id,
            'status' => Game::STATUS_STARTED
        ]);

        return $this->getGame($id);
    } catch (PDOException $e) {
        throw new RepositoryNotFoundException("Impossible de démarrer la partie : " . $e->getMessage());
    }
}


}