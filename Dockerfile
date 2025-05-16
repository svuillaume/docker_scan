# 🚨 EOL Python 2.7 image with known CVEs
FROM python:2.7

# Set working directory
WORKDIR /app

# Copy vulnerable app code
COPY . /app

# Install vulnerable Flask version
RUN pip install Flask==0.10  # ⚠️ multiple known CVEs

# Simulate secret exposure in environment
ENV AWS_SECRET_ACCESS_KEY="AKIAFAKESECRETKEY"
ENV DB_PASSWORD="root"

# Expose port
EXPOSE 5000

# Run app as root (insecure)
CMD ["python", "app.py"]



