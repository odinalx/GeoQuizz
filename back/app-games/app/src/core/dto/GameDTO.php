<?php
namespace geoquizz\core\dto;

use geoquizz\core\domain\entities\games\Game;

class GameDTO extends DTO {

    protected string $id;
    protected string $creatorId;
    protected string $serieId;
    protected string $status;
    protected int $score;
    protected \DateTimeImmutable $created_at;

    public function __construct(Game $game) {
        $this->id = $game->getID();
        $this->creatorId = $game->creatorId;
        $this->serieId = $game->serieId;
        $this->status = $game->status;
        $this->score = $game->score;
        $this->created_at = $game->created_at;
    }

    public function toEntity(): Game {
        $game = new Game($this->creatorId, $this->serieId);
        $game->setID($this->id);
        $game->setStatus($this->status);
        $game->setScore($this->score);
        $game->setCreatedAt($this->created_at);
        return $game;
    }
}