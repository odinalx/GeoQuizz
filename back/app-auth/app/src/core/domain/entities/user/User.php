<?php
namespace geoquizz\core\domain\entities\user;

use geoquizz\core\domain\entities\Entity;
use Ramsey\Uuid\Guid\Guid;

class User extends Entity{

    protected string $email;
    protected string $password;
    protected string $role;

    public function __construct(string $email, string $password, string $role){
        $this->email = $email;
        $this->password = $password;
        $this->role = $role;
        $this->setID(Guid::uuid4()->toString());
    }

    public function getEmail(){
        return $this->email;
    }

    public function getPassword(){
        return $this->password;
    }

    public function getRole(){
        return $this->role;
    }

}