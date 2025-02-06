<?php

namespace geoquizz\infrastructure\adapter;

use geoquizz\core\repositoryInterfaces\PhotosRepositoryInterface;
use GuzzleHttp\ClientInterface;

class PhotosRepositoryAdapter implements PhotosRepositoryInterface
{
    private ClientInterface $client;

    public function __construct(ClientInterface $client)
    {
        $this->client = $client;
    }

    public function getPhotoById(string $id): array
    {
        $query = http_build_query([
            'filter' => json_encode(['id' => ['_eq' => $id]])
        ]);

        $response = $this->client->request('GET', "items/photos?$query");

        return json_decode($response->getBody(), true);
    }
}
