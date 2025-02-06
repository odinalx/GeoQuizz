<?php
namespace geoquizz\core\domain\entities\photos;

use geoquizz\core\domain\entities\Entity;

class Photo extends Entity {

    protected string $serie_id;
    protected string $name;
    protected string $lat;
    protected string $long;
    protected string $url;
    protected string $link;

    public function __construct(string $serie_id, string $name, string $lat, string $long, string $url, string $link){
        $this->serie_id = $serie_id;
        $this->name = $name;
        $this->lat = $lat;
        $this->long = $long;
        $this->url = $url;
        $this->link = $link;
    }

}