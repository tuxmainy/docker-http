FROM php:7-apache

# Apache Modules
RUN a2enmod rewrite dav dav_fs dav_lock

# PHP Modules
ENV DEBIAN_FRONTEND noninterative

## opcache
RUN docker-php-ext-configure opcache && docker-php-ext-install -j$(nproc) opcache

## pgsql
RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-configure pgsql && docker-php-ext-install pgsql

# PHP ini
RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY ini/prod.ini /usr/local/etc/php/conf.d
COPY ini/opcache.ini /usr/local/etc/php/conf.d
