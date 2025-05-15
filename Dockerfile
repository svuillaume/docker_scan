#FROM alpine:latest
#CMD ["echo", "helloworld"]

FROM ubuntu:16.04

RUN apt-get update && apt-get install -y curl

ENV SECRET_KEY=123456

WORKDIR /app

RUN echo "<?php echo 'Vulnerable App'; ?>" > index.php

EXPOSE 80

CMD ["bash"]

