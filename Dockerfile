# A minimal and safe Dockerfile that installs packages and echoes "hello world"
FROM debian:bookworm-slim

# Install packages (curl and vim as example), then clean up to reduce image size
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        vim && \
    rm -rf /var/lib/apt/lists/*

# Default command
CMD ["sh", "-c", "echo hello world"]

