#!/bin/bash
# Stop REACTOR SIEM stack

set -e

echo "Stopping REACTOR SIEM..."

# Stop all services
docker-compose down

echo "REACTOR SIEM stopped successfully!"

# Optional cleanup
read -p "Do you want to remove all volumes (THIS WILL DELETE ALL DATA)? [y/N]: " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing all volumes..."
    docker-compose down -v
    echo "All data removed."
fi