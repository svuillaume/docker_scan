# 🐛 Use an outdated Java base image with known vulnerabilities
FROM openjdk:8-jdk

# ⛔ Add insecure ENV variables (secret exposure)
ENV DB_USERNAME=root
ENV DB_PASSWORD=SuperSecret123!
ENV AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
ENV AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

WORKDIR /app

# 🐛 Download vulnerable Log4j (CVE-2021-44228)
ADD https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.14.1/log4j-core-2.14.1.jar .
ADD https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.14.1/log4j-api-2.14.1.jar .

# 🔓 Copy in a vulnerable Java app
COPY VulnerableApp.java .

# 🔧 Compile the app
RUN javac -cp "log4j-core-2.14.1.jar:log4j-api-2.14.1.jar" VulnerableApp.java

# 🧨 Expose a port (simulate a running service)
EXPOSE 8080

# 🚨 Run the vulnerable app
CMD ["java", "-cp", ".:log4j-core-2.14.1.jar:log4j-api-2.14.1.jar", "VulnerableApp"]
