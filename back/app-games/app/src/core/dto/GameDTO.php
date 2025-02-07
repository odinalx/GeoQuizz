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
    protected array $photos = [];

    public function __construct(Game $game) {
        $this->id = $game->getID();
        $this->creatorId = $game->creatorId;
        $this->serieId = $game->serieId;
        $this->status = $game->status;
        $this->score = $game->score;
        $this->created_at = $game->created_at;
        $this->photos = $game->photos;
    }

    public function getPhotos(): array {
        $photosArray = [];
        foreach ($this->photos as $photo) {
            $photosArray[] = [
                'id' => $photo->getID(),
                'serie_id' => $photo->serie_id,
                'name' => $photo->name,
                'lat' => $photo->lat,
                'long' => $photo->long,
                'file' => $photo->file,
                'link' => $photo->link
            ];
        }
        return $photosArray;
    }
    

    public function toEntity(): Game {
        $game = new Game($this->creatorId, $this->serieId);
        $game->setID($this->id);
        $game->setStatus($this->status);
        $game->setScore($this->score);
        $game->setCreatedAt($this->created_at);
        $game->setPhotos($this->photos);
        return $game;
    }
}