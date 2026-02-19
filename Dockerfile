# Use official Python runtime as base image
FROM python:3.11-slim

# Set working directory in container
WORKDIR /app

# Install system dependencies (if needed for some packages)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for better layer caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy entire application
COPY . .

# Expose port (Flask default is 5000)
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=flask_app.py
ENV FLASK_ENV=production

# Run the Flask application
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
