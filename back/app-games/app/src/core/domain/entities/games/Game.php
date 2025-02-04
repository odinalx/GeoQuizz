<?php
namespace geoquizz\core\domain\entities\games;

use geoquizz\core\domain\entities\Entity;
use geoquizz\core\dto\GameDTO;
use Ramsey\Uuid\Guid\Guid;

class Game extends Entity {

    private const STATUS_CREATED = "CREATED";
    private const STATUS_STARTED = "STARTED";
    private const STATUS_FINISHED = "FINISHED";

    protected string $creatorId;
    protected string $serieId;
    protected string $status= self::STATUS_CREATED;
    protected int $score;
    protected \DateTimeImmutable $created_at;

    public function __construct(string $creatorId, string $serieId){
        $this->setID(Guid::uuid4()->toString());            
        $this->creatorId = $creatorId;
        $this->serieId = $serieId;
        $this->score = 0;
        $this->created_at = new \DateTimeImmutable();
    }

    public function setStatus(string $status){
        $this->status = $status;
    }

    public function setScore(int $score){
        $this->score = $score;
    }

    public function setCreatedAt(\DateTimeImmutable $created_at){
        $this->created_at = $created_at;
    }

    public function toDTO(): GameDTO {
        return new GameDTO($this);
    }
}