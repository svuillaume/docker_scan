FROM debian:stretch-slim

# Install old vulnerable version of OpenSSL
RUN echo "deb http://snapshot.debian.org/archive/debian/20170701T000000Z stretch main" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y openssl=1.1.0c-2 && \
    rm -rf /var/lib/apt/lists/*

# Add a root-level script (bad practice)
COPY vulnerable.sh /vulnerable.sh
RUN chmod +x /vulnerable.sh

CMD ["/vulnerable.sh"]
