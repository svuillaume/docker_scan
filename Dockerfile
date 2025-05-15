FROM python:2.7  # ❌ EOL base image with many CVEs

WORKDIR /app

# Copy vulnerable app
COPY vulnerable.py .

# ❌ Install outdated, vulnerable packages
RUN pip install --no-cache-dir flask==0.10 requests==2.6.0

# ❌ Simulated hardcoded root password in image layer
RUN echo "root:root" > /root/credentials.txt

EXPOSE 5000

CMD ["python", "vulnerable.py"]
