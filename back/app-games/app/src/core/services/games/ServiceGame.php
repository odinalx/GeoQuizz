<?php

namespace geoquizz\core\services\games;

use geoquizz\core\domain\entities\games\Game;
use geoquizz\core\dto\InputGameDTO;
use geoquizz\core\dto\GameDTO;
use geoquizz\core\repositoryInterfaces\GameRepositoryInterface;
use geoquizz\core\repositoryInterfaces\PhotosRepositoryInterface;
use geoquizz\core\services\games\ServiceCreationErrorException;
use geoquizz\infrastructure\PDO\RepositoryCreationErrorException;
use geoquizz\infrastructure\PDO\GameNotFoundException;
use geoquizz\infrastructure\PDO\GameStatusException;
use geoquizz\core\domain\entities\photos\Photo;
use app\providers\JWTManager;

class ServiceGame implements ServiceGameInterface
{
    private GameRepositoryInterface $gameRepository;
    private PhotosRepositoryInterface $photosRepository;

    public function __construct(GameRepositoryInterface $gameRepository, PhotosRepositoryInterface $photosRepository)
    {
        $this->gameRepository = $gameRepository;
        $this->photosRepository = $photosRepository;
    }

    public function createGame(InputGameDTO $g): GameDTO
    {
        try {
            $game = new Game($g->creatorId, $g->serieId);
            $savedGame = $this->gameRepository->save($game);
            $gameId = $savedGame->id;

            $photos = $this->photosRepository->getPhotosBySerieId($game->serieId);

            $this->gameRepository->savePhotos($gameId, $photos);

            return $savedGame;
        } catch (RepositoryCreationErrorException $e) {
            throw new ServiceCreationErrorException($e->getMessage());
        }
    }

    public function getGame(string $id): GameDTO
    {
        try {
            $photoIds = $this->gameRepository->getPhotos($id);

            $photos = [];
            foreach ($photoIds as $photoId) {
                $photoData = $this->photosRepository->getPhotoById($photoId);
                $photoData = $photoData['data'][0];

                $photo = new Photo(
                    $photoData['serie_id'],
                    $photoData['name'],
                    $photoData['lat'],
                    $photoData['long'],
                    $photoData['file'],
                    $photoData['link']
                    
                );
                $photo->setID($photoData['id']);

                $photos[] = $photo;
            }

            $game = $this->gameRepository->getGame($id)->toEntity();

            $game->setPhotos($photos);

            return $game->toDTO();
        } catch (GameNotFoundException $e) {
            throw new ServiceNotFoundException($e->getMessage());
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }


    public function startGame(string $id): GameDTO
    {
        try {
            return $this->gameRepository->startGame($id);
        } catch (GameNotFoundException $e) {
            throw new ServiceNotFoundException($e->getMessage());
        } catch (GameStatusException $e) {
            throw new GameAlreadyStartException($e->getMessage());
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public function finishGame(string $id): GameDTO
    {
        try {
            return $this->gameRepository->finishGame($id);
        } catch (GameNotFoundException $e) {
            throw new ServiceNotFoundException($e->getMessage());
        } catch (GameStatusException $e) {
            throw new GameAlreadyStartException($e->getMessage());
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public function play(string $gameid, string $photoid, string $lat, string $long, string $time): GameDTO
    {
        try {
            $game = $this->getGame($gameid);
            if (!$game) {
                throw new ServiceNotFoundException("Partie non trouvée");
            }

            if ($game->status === Game::STATUS_FINISHED) {
                throw new GameStatusException("La partie est déjà terminée");
            } else if ($game->status === Game::STATUS_CREATED) {
                throw new GameStatusException("La partie n'est pas démarrée");
            }


            $photo = $this->photosRepository->getPhotoById($photoid);
            $photoData = $photo['data'][0];
            if (!$photoData) {
                throw new ServiceNotFoundException("Photo non trouvée");
            }

            $photoLat = $photoData['lat'];
            $photoLong = $photoData['long'];

            $distance = $this->calculateDistance($photoLat, $photoLong, $lat, $long);

            $D = 0.5; //500m

            // Calcul du score basé sur la distance
            $points = 0;
            if ($distance < $D) {
                $points = 5;
            } elseif ($distance < 2 * $D) {
                $points = 3;
            } elseif ($distance < 3 * $D) {
                $points = 1;
            }

            // Prise en compte du temps de réponse
            if ($time < 5) {
                $points *= 4;
            } elseif ($time < 10) {
                $points *= 2;
            } elseif ($time > 20) {
                $points = 0;
            }

            $newScore = $game->score + $points;

            return $this->gameRepository->saveScore($gameid, $newScore);
        } catch (\Exception $e) {
            throw new \Exception("Impossible de jouer: " . $e->getMessage());
        }
    }

    public function createGameToken(string $gameid): string
    {
        $jwt = new JWTManager();
        return $jwt->createAccessToken([
            'sub' => $gameid,
            'exp' => time() + 3600, // Access token valable 1 heure
        ]);
    }

    private function calculateDistance(string $photoLat, string $photoLong, string $lat, string $long): float
    {
        $latDiff = ((float)$lat - (float)$photoLat) * 111;
        $longDiff = ((float)$long - (float)$photoLong) * 111 * cos(deg2rad($photoLat));

        return sqrt($latDiff ** 2 + $longDiff ** 2);
    }
}
