FROM ubuntu:18.04

# Install Java (needed for Log4j)
RUN apt-get update && \
    apt-get install -y openjdk-8-jre wget && \
    apt-get clean
CMD ["echo", "hello2 Starting vulnerable app..."]

