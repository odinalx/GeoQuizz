<?php 
namespace geoquizz\core\repositoryInterfaces;

interface PhotosRepositoryInterface {
    public function getPhotoById(string $id): array;
}