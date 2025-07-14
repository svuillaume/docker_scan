FROM debian:stretch

# Replace expired APT sources and disable validation
RUN sed -i 's|http://deb.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Install dependencies
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysqli \
    php-gd \
    mariadb-client \
    git \
    unzip \
    wget \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Clone DVWA
RUN git clone https://github.com/digininja/DVWA.git /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 777 /var/www/html

# Configure DVWA (insecure default)
RUN cp /var/www/html/config/config.inc.php.dist /var/www/html/config/config.inc.php

# Add insecure secrets
RUN echo "AWS_SECRET_KEY=AKIAFAKESECRET123456789" > /root/.env && \
    echo "API_KEY=verybadinsecurekey" >> /root/.env

# Add fake private key
RUN mkdir -p /root/.ssh && \
    printf '%s\n' \
"-----BEGIN RSA PRIVATE KEY-----" \
"MIIEpAIBAAKCAQEAv0v5hZ0I1F3y4ZAmvqziZP1+ZuDeU9RjYkJD9i4v5gS8ohAb" \
"b7zKlJdTbZBgZglLzBslh0y+PwS2uCJUXKT4h6H6KNmBrv2fLwH1vuvLf9Af3Yef" \
"YJxDNdVvT1ENeNvQUHjj1vP2ZwIDAQABAoIBAQCgZT0mL+R0iV8YjvQKQ0J2+zUY" \
"-----END RSA PRIVATE KEY-----" \
> /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa

# Expose secrets into the web root
RUN cp /root/.env /var/www/html/secrets.env && \
    cp /root/.ssh/id_rsa /var/www/html/ssh-key.pem && \
    chmod 644 /var/www/html/secrets.env /var/www/html/ssh-key.pem

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
