FROM busybox

COPY . /app
WORKDIR /app

CMD ["sh", "-c", "echo hello world"]
