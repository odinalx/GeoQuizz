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

### **Accéder aux services**

- **Frontend** : [http://localhost:5173](http://localhost:5173)
- **API REST GeoQuizz** : [http://localhost:8082](http://localhost:8082)
- **Service WebSocket** : ws://localhost:8083
- **Backoffice Directus** : [http://localhost:8055](http://localhost:8055)

## 👥 Collaborateurs

- **Alexandre Odin**
- **Georges Victor**
- **Muñoz Ramírez José Guadalupe**
- **Martinez Ortuño Galo Eduardo**
