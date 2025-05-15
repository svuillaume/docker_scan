# Use a known vulnerable Debian version (CVE-rich)
FROM debian:9.5

# Add outdated and vulnerable packages
RUN apt-get update && \
    apt-get install -y \
      openssl=1.1.0f-3+deb9u2 \
      libssl1.1=1.1.0f-3+deb9u2 \
      curl && \
    apt-get clean

# Simulate a dummy app
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]



