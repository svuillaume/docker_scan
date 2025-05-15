# Use an official PHP + Apache image
FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    mariadb-server \
    && docker-php-ext-install mysqli pdo pdo_mysql gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Clone DVWA
RUN git clone https://github.com/digininja/DVWA.git /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Copy DVWA config
COPY config.inc.php /var/www/html/config/config.inc.php

# Expose web port
EXPOSE 80

# Start both Apache and MySQL when the container runs
CMD service mysql start && apache2-foreground

