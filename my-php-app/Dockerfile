FROM php:8.2-apache

# MySQL PDO installieren
RUN docker-php-ext-install pdo pdo_mysql

# Dateien in Web-Ordner kopieren
COPY . /var/www/html/
