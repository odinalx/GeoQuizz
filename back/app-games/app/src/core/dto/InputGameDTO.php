<?php

namespace geoquizz\core\dto;

use Respect\Validation\Validator as v;
use geoquizz\core\domain\entities\games\Game;

class InputGameDTO extends DTO {
    protected string $creatorId;
    protected string $serieId;

    public function __construct(string $creatorId, string $serieId) {
        $this->creatorId = $creatorId;
        $this->serieId = $serieId;

        $this->setBusinessValidator(
            v::attribute('creatorId', v::uuid()->notEmpty())
             ->attribute('serieId', v::uuid()->notEmpty())
        );
    }

    public function toEntity(): Game {
        return new Game($this->creatorId, $this->serieId);
    }
}
