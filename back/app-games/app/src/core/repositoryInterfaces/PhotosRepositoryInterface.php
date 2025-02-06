<?php 
namespace geoquizz\core\repositoryInterfaces;

interface PhotosRepositoryInterface {
    public function getPhotoById(string $id): array;
    public function getPhotosBySerieId(string $id): array;
}