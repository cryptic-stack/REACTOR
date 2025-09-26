#!/bin/bash
# Start REACTOR SIEM stack

set -e

echo "Starting REACTOR SIEM..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker first."
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose > /dev/null 2>&1; then
    echo "Error: docker-compose is not installed."
    exit 1
fi

# Start all services
echo "Starting all REACTOR services..."
docker-compose up -d

echo "Waiting for services to be healthy..."
sleep 30

# Check service health
echo "Checking service health..."
docker-compose ps

echo "REACTOR SIEM started successfully!"
echo
echo "To complete setup, run: ./scripts/init-all.sh"
echo
echo "Services starting up... This may take a few minutes."
echo "You can monitor logs with: docker-compose logs -f"