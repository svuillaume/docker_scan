# Base image with known CVEs
FROM ubuntu:16.04

# Install outdated and vulnerable packages
RUN apt-get update && \
    apt-get install -y openssl wget curl python && \
    apt-get clean

# Add a secret directly in the image
ENV AWS_SECRET_ACCESS_KEY="hardcoded-SECRET-key-123456"

# Run the container as root (default, but should be avoided)
USER root

# Add a remote file from an untrusted source
ADD http://example.com/unknown.tar.gz /tmp/code.tar.gz

# No health check defined
# No non-root user created
# No minimal packages used
CMD ["bash"]

