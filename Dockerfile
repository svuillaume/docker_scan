FROM debian:stretch-slim

COPY vulnerable /vulnerable
COPY entrypoint /entrypoint
RUN chmod +x /vulnerable /entrypoint

CMD ["/entrypoint"]
