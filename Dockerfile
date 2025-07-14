FROM php:5.6-apache

RUN a2enmod rewrite

# Install vulnerable packages
RUN apt-get update && \
    apt-get install -y \
      git \
      mariadb-client \
      unzip && \
    rm -rf /var/lib/apt/lists/*

# Clone DVWA vulnerable app
RUN git clone https://github.com/digininja/DVWA.git /var/www/html

# Create insecure secret and SSH key files
RUN mkdir -p /root/.ssh && \
    printf '%s\n' \
"-----BEGIN RSA PRIVATE KEY-----" \
"MIIEpAIBAAKCAQEA1KjN6w7RQnZfRk7IVtkbMoP5lA0uEJ2JfNjHdqnn4n+9Yrlw" \
"x3N1D4v8v9gA1VzAjkzY+yO4KMBukVklNv6E5z0QKBgQDLvjOZ6vhMx1x7fEp0u3Q" \
"wIDAQABAoIBAQCq9EvTxY4vZx+JZ1B3Et+PvPmlqKdj0Bt9UJ2OYo1VZrhT" \
"-----END RSA PRIVATE KEY-----" \
> /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa

# Make secrets world-readable to simulate worst-case scenario
RUN chmod 644 /root/.aws/credentials /root/.env

# Expose Apache
EXPOSE 80

CMD ["apache2-foreground"]



