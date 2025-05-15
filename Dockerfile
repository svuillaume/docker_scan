# Use an OpenJDK base image
FROM openjdk:8-jdk-alpine

# Set work directory
WORKDIR /app

# Download a vulnerable version of log4j (2.14.1 is vulnerable to Log4Shell)
ADD https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.14.1/log4j-core-2.14.1.jar log4j-core.jar
ADD https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.14.1/log4j-api-2.14.1.jar log4j-api.jar

# Add your vulnerable Java app (below)
COPY VulnerableApp.java .

# Compile it
RUN javac -cp "log4j-core.jar:log4j-api.jar" VulnerableApp.java

# Run the app on container start
CMD ["java", "-cp", ".:log4j-core.jar:log4j-api.jar", "VulnerableApp"]
