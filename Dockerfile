# Python 2.7 image with known CVEs
FROM python:2.7

# Set working directory
WORKDIR /app

# Install sudo and bash
RUN apt-get update && \
    apt-get install -y bash && \
    rm -rf /var/lib/apt/lists/*

# Add a non-root user with sudo (optional)
RUN useradd -ms /bin/bash user && echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Copy vulnerable app code
COPY . /app

# Install vulnerable Flask version
RUN pip install Flask==0.10  # ⚠️ multiple known CVEs

# Simulate secret exposure in environment
ENV AWS_SECRET_ACCESS_KEY="AKIAFAKESECRETKE123456"
ENV PASSWORD="root"

# Expose port
EXPOSE 5555

# Default to Bash shell with sudo
CMD ["bash"]


