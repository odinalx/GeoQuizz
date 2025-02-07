# GeoQuizz - Jeu de Géolocalisation

## 📌 À propos du projet

GeoQuizz est un jeu web inspiré de **GeoGuessr**, où les joueurs doivent placer des photos sur une carte en fonction de leur emplacement réel. Plus la position est précise et la réponse rapide, plus le joueur gagne de points. Le projet repose sur une architecture **microservices** et est développé en **Vue.js**, **PHP/Slim**, et **Directus**.

## 🚀 Fonctionnalités

## 🔌 Ports utilisés

| Service                 | Port |
|-------------------------|------|
| Application frontend (Vue.js) | **5173** |
| API REST GeoQuizz (PHP/Slim) | **8082** |
| Service WebSocket | **8083** |
| Backoffice GeoQuizz (Directus) | **8055** |

## 🛠️ Installation et exécution du projet

### **Cloner le projet**

```bash
 git clone https://github.com/votre-repository/geoquizz.git
 cd geoquizz
```

### **Lancer les services avec Docker**

```bash
docker-compose up -d --build
```

## **Sauvegarder les dumps des deux bases de données**

```bash
docker exec -t db-auth-geoquizz pg_dump -U root -d authdb --data-only --column-inserts > back/app-auth/sql/3-data.sql
docker exec -t db-games-geoquizz pg_dump -U root -d gamesdb --data-only --column-inserts > back/app-games/sql/3-data.sql

```

### **Sauvergarder un dump de la bd Directus si on fait des changements dedans**

```bash
cd back/app-directus/data
docker exec -t db-directus-geoquizz pg_dump -U root -d directusdb > data.sql
```

### **Configuration des hosts pour tester en local**

Ajout des domaines dans le fichier hosts local :

- Sur Windows, le fichier se trouve dans C:\Windows\System32\drivers\etc\hosts
- Sous Linux, le fichier se trouve dans  /etc/hosts

```
127.0.0.1 gateway.geoquizz
127.0.0.1 api.auth
127.0.0.1 api.games
127.0.0.1 api.directus
```

### **Accéder aux services**

- **Frontend** : [http://localhost:33555](http://localhost:33555)
- **API REST GeoQuizz** : [http://localhost:33554](http://localhost:33554) | [http://gateway.geoquizz:33554](http://gateway.geoquizz:33554)
- **Backoffice GeoQuizz** : [http://localhost:33556](http://localhost:33556) | [http://api.directus:33556](http://api.directus:33556)
- **Service Email** : 

### **Routes**

#### **Games**

- Créer une partie -> **POST /games** avec Header "Authorization Bearer *token*" | Body : *creatorId* et *serieId*
- Récupérer une partie -> **GET /games/{id}** avec Header "Authorization Bearer *token*" et avec Header "X-Game-Token *token*"
- Lancer une partie -> **PATCH /games/{id}/start** avec Header "Authorization Bearer *token*" et avec Header "X-Game-Token *token*"
- Terminer une partie -> **PATCH /games/{id}/finish** avec Header "Authorization Bearer *token*" et avec Header "X-Game-Token *token*"
- Jouer un coup -> **POST /games/{id}** avec Header "Authorization Bearer *token*" et avec Header "X-Game-Token *token*" | Body : *photoid*, *lat*, *long*, *time*

#### **Authentification**

- Enregistrer un utilisateur -> **POST /auth/register** | Body : *email*, *password*, *role*
- Se connecter -> **POST /auth/login** | Body : *email*, *password*
- Refresh un token -> **POST /auth/refresh** | Body : *refershToken*
- Valider un token -> **POST /tokens/validate** avec Header "Authorization Bearer *token*"

## 👥 Collaborateurs

- **Alexandre Odin**
- **Georges Victor**
- **Martinez Ortuño Galo Eduardo**
