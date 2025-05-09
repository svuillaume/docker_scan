FROM ubuntu:18.04

# Install Java (needed for Log4j)
RUN apt-get update && \
    apt-get install -y openjdk-8-jre wget && \
    apt-get clean

# Download vulnerable Log4j JAR (2.14.1 has CVE-2021-44228 - Log4Shell)
RUN mkdir /app && \
    wget -O /app/log4j-core-2.14.1.jar https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.14.1/log4j-core-2.14.1.jar

CMD ["echo", "hello2 Starting vulnerable app..."]

