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
RUN echo "AWS_SECRET_KEY=AKIAFAKESECRET123456789" > /root/.aws/credentials && \
    echo "p@ssw0rd" > /root/.env && \
    mkdir -p /root/.ssh && \
    echo '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAzVxH+phgFakGZB3VlGm5uyM1zOpHTRmAeQQGzp+hzHb3KYLF
fX+Hj27jVRea7OSDpjXq3M1vZTjZ2B5JPkFMgKeKoTjTg9eWa6kR93jOztZzU5JHg
x...
-----END RSA PRIVATE KEY-----' > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa

# Make secrets world-readable to simulate worst-case scenario
RUN chmod 644 /root/.aws/credentials /root/.env

# Expose Apache
EXPOSE 80

CMD ["apache2-foreground"]



