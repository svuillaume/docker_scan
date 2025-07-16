# Use a minimal base image
FROM python:3.11-alpine

# Set non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set working directory
WORKDIR /app

# Install dependencies securely
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Change ownership to non-root user
RUN chown -R appuser:appgroup /app

# Drop to non-root user
USER appuser

# Expose the application port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
