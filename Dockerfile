FROM vulnerables/web-dvwa

# Fix expired Debian APT mirrors and install packages
RUN sed -i 's|http://deb.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    apt-get update && \
    apt-get install -y \
        git \
        mariadb-client \
        unzip && \
    rm -rf /var/lib/apt/lists/*

# Create insecure environment variable file
RUN echo "API_KEY=super-insecure-api-key-123456" > /root/.env && \
    echo "AWS_SECRET_KEY=AKIAFAKESECRET123456789" >> /root/.env && \
    chmod 644 /root/.env

# Add a dummy private SSH key
RUN mkdir -p /root/.ssh && \
    printf '%s\n' \
"-----BEGIN RSA PRIVATE KEY-----" \
"MIIEpAIBAAKCAQEAv0v5hZ0I1F3y4ZAmvqziZP1+ZuDeU9RjYkJD9i4v5gS8ohAb" \
"b7zKlJdTbZBgZglLzBslh0y+PwS2uCJUXKT4h6H6KNmBrv2fLwH1vuvLf9Af3Yef" \
"YJxDNdVvT1ENeNvQUHjj1vP2ZwIDAQABAoIBAQCgZT0mL+R0iV8YjvQKQ0J2+zUY" \
"-----END RSA PRIVATE KEY-----" \
> /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa

# Copy secrets into the web root (to simulate exposure)
RUN cp /root/.env /var/www/html/secrets.env && \
    cp /root/.ssh/id_rsa /var/www/html/ssh-key.pem && \
    chmod 644 /var/www/html/secrets.env /var/www/html/ssh-key.pem

EXPOSE 80

CMD ["apache2-foreground"]
