<?php
namespace geoquizz\infrastructure\PDO;

use PDO;
use PDOException;
use geoquizz\core\repositoryInterfaces\GameRepositoryInterface;
use geoquizz\core\domain\entities\games\Game;
use geoquizz\core\dto\GameDTO;
use geoquizz\infrastructure\PDO\RepositoryCreationErrorException;

class PdoGameRepository implements GameRepositoryInterface {

    private PDO $pdo_rdv;
    
    public function __construct(PDO $pdo_rdv)
    {
        $this->pdo_rdv = $pdo_rdv;
    }

    public function save(Game $game): GameDTO {
        try {
            $stmt = $this->pdo_rdv->prepare('INSERT INTO games (id, creator_id, serie_id, status, score, created_at ) VALUES (:id, :creator_id, :serie_id, :status, :score, :created_at)');
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

}