FROM php:7.4-fpm

RUN apt update && apt install -y curl git unzip
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html/
WORKDIR /var/www/html/hello-world

RUN composer install --optimize-autoloader --no-dev
RUN php artisan config:cache
# RUN php artisan route:cache       # this was raising an error in php
RUN php artisan view:cache

ENTRYPOINT [ "php", "artisan", "serve", "--host", "0.0.0.0" ]
