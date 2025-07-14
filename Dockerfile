FROM ubuntu:18.04

# Use of deprecated base image (no longer receives security updates)
# Best: Use a supported, minimal base image (e.g., ubuntu:22.04, debian:bullseye-slim, or alpine)

# Running as root (default in Docker, but should be explicitly addressed or changed)
USER root

# Installing packages without verifying checksums or using minimal layers
RUN apt-get update && \
    apt-get install -y curl git && \
    rm -rf /var/lib/apt/lists/*

# Secrets hardcoded directly into image
RUN mkdir -p /root/.aws /root/.ssh

RUN echo "AWS_SECRET_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE-DEM02100" > /root/.aws/credentials && \
    echo "PRIVATE_KEY=very-insecure-key" > /root/.env

# Insecure SSH private key written into image
RUN echo "FAKE-PRIVATE-KEY" > /root/.ssh/id_rsa

# Files copied into non-secure locations, with world-readable permissions
RUN cp /root/.env /secrets.env && \
    cp /root/.ssh/id_rsa /ssh-key.pem && \
    chmod 644 /secrets.env /ssh-key.pem

# No HEALTHCHECK defined
# Best: Add a HEALTHCHECK for long-running containers

# Default CMD runs an interactive shell (not suitable for production)
CMD ["/bin/bash"]
