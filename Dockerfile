# ⚠️ FOR SCANNING TEST PURPOSES ONLY
FROM debian:stretch

RUN apt-get update && \
    apt-get install -y wget curl vim && \
    echo "deb http://snapshot.debian.org/archive/debian/20170701T000000Z stretch main" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y openssl=1.1.0c-2 && \
    rm -rf /var/lib/apt/lists/*

# Simulate a secret exposed in image
ENV AWS_SECRET_ACCESS_KEY="AKIA-CRITICAL-EXAMPLE-1234"

CMD ["/bin/bash"]

# new comment hello
