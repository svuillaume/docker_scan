FROM debian:9.5

# Install outdated tools (from old Debian)
RUN apt-get update && \
    apt-get install -y \
      openssl \
      libssl1.1 \
      passwd && \
    echo "root:weakpassword123" | chpasswd

# Add simple script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]

