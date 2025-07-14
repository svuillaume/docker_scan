FROM ubuntu:18.04

# Insecure secrets
RUN echo "AWS_SECRET_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE" > /root/.aws/credentials && \
    echo "PRIVATE_KEY=very-insecure-key" > /root/.env

# Exposed SSH private key
RUN mkdir -p /root/.aws && \
    echo "AWS_SECRET_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE" > /root/.aws/credentials && \
    echo "PRIVATE_KEY=very-insecure-key" > /root/.env


# Add secrets to exposed location
RUN cp /root/.env /secrets.env && \
    cp /root/.ssh/id_rsa /ssh-key.pem && \
    chmod 644 /secrets.env /ssh-key.pem

CMD ["/bin/bash"]
