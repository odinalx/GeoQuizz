FROM php:8.3-cli

# Mise à jour des paquets et installation des extensions nécessaires
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Définition du répertoire de travail
WORKDIR /var/app

# Copie des fichiers de l'application
COPY . .

# Installation de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader

# Exposition du port 80
EXPOSE 80

# Commande de démarrage
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/app/public"]
