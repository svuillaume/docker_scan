# Base image: outdated and with known CVEs
FROM ubuntu:16.04

# Use root user explicitly (insecure)
#USER root

# Install outdated and vulnerable packages without version pinning
RUN apt-get update && \
    apt-get install -y curl openssh-server nginx && \

# Add a plaintext secret (VERY BAD)
#ENV AWS_SECRET_ACCESS_KEY="ABCD1234EFGH5678IJKL"

# Copy code without checking integrity or signing
ADD http://example.com/unknown.tar.gz /tmp/code.tar.gz

# Expose high-risk port
#EXPOSE 22

# Start nginx (should be managed by a proper init system)
CMD ["nginx", "-g", "daemon off;"]

