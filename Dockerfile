FROM php:7.4-apache  # ✅ Compatible with DVWA, but EOL for some CVE scanners

WORKDIR /var/www/html

# ❌ Hardcoded root password (bad practice)
RUN echo "root:superinsecure123" > /root/credentials.txt

# ✅ Install required packages
RUN apt-get update && apt-get install -y \
    git \
    mariadb-server \
    unzip \
    && docker-php-ext-install mysqli pdo pdo_mysql

# ✅ Enable Apache mod_rewrite
RUN a2enmod rewrite

# ✅ Clone DVWA source
RUN git clone https://github.com/digininja/DVWA.git .

# ✅ Set write permissions for DVWA config
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# ✅ Copy default config if needed
RUN cp config/config.inc.php.dist config/config.inc.php

EXPOSE 80

CMD ["apache2-foreground"]


