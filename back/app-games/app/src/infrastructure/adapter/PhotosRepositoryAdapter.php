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

    public function getPhotosBySerieId(string $id): array
    {
        // Requête pour obtenir les photos avec le filtre serie_id
        $query = http_build_query([
            'filter' => json_encode(['serie_id' => ['_eq' => $id]])
        ]);

        $response = $this->client->request('GET', "items/photos?$query");

        // Décoder la réponse JSON
        $photosData = json_decode($response->getBody(), true);

        // Si des photos ont été trouvées
        if (isset($photosData['data']) && count($photosData['data']) > 0) {
            // Extraire uniquement les IDs des photos
            $photoIds = [];
            foreach ($photosData['data'] as $photoData) {
                $photoIds[] = $photoData['id']; // Ajout des IDs des photos dans un tableau
            }

            // Mélanger les IDs de manière aléatoire
            shuffle($photoIds);

            // Retourner les 10 premiers IDs de photos aléatoires
            return array_slice($photoIds, 0, 10);
        }

        return [];
    }
}
