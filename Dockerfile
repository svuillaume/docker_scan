FROM openjdk:8

WORKDIR /tmp

# Download vulnerable Log4J JARs
ADD https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.14.1/log4j-core-2.14.1.jar .
ADD https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.14.1/log4j-api-2.14.1.jar .

# Copy Java file
COPY VulnerableApp.java .

# Compile
RUN javac -cp "log4j-core-2.14.1.jar:log4j-api-2.14.1.jar" VulnerableApp.java

# Run
CMD ["java", "-cp", ".:log4j-core-2.14.1.jar:log4j-api-2.14.1.jar", "VulnerableApp"]
