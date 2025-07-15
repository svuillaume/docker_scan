# ⚠️ FOR TESTING PURPOSES ONLY — Contains known vulnerabilities
FROM ubuntu:16.04

# Install outdated, vulnerable packages
RUN apt-get update && \
    apt-get install -y \
    openssl=1.0.2g-1ubuntu4.20 \
    wget \
    curl \
    vim && \
    rm -rf /var/lib/apt/lists/*

# Optional: Simulate sensitive info exposure (for scanner rules)
ENV AWS_SECRET_ACCESS_KEY="AKIAIOSFODNN7EXAMPLE"

CMD ["/bin/bash"]

# new comment hello
