# Use a vulnerable base image
FROM debian:9.5

# Install outdated OpenSSL and tools
RUN apt-get update && \
    apt-get install -y \
      openssl=1.1.0f-3+deb9u2 \
      libssl1.1=1.1.0f-3+deb9u2 \
      passwd && \
    echo "root:weakpassword123" | chpasswd

# Add simple entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]



