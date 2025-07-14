FROM ubuntu:18.04

# Create required directories
RUN mkdir -p /root/.aws /root/.ssh

# Add insecure dummy secrets (for test purpose only)
RUN echo "AWS_SECRET_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE" > /root/.aws/credentials && \
    echo "PRIVATE_KEY=very-insecure-key" > /root/.env

# Only if the id_rsa file exists or was copied earlier into the image
# To simulate in test: create a dummy key
RUN echo "FAKE-PRIVATE-KEY" > /root/.ssh/id_rsa

# Copy to exposed location (still insecure!)
RUN cp /root/.env /secrets.env && \
    cp /root/.ssh/id_rsa /ssh-key.pem && \
    chmod 644 /secrets.env /ssh-key.pem

CMD ["/bin/bash"]
