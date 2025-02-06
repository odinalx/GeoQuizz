FROM php:8.2-cli


RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    && docker-php-ext-install pdo pdo_pgsql bcmath


COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


WORKDIR /var/php


COPY . .


RUN composer install --no-dev --optimize-autoloader


EXPOSE 80


CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/php/public"]
