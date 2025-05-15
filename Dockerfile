FROM ubuntu:18.04

# Install outdated but still vulnerable system tools
RUN apt-get update && \
    apt-get install -y openssl passwd && \
    echo "root:weakpassword123" | chpasswd

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]


