#!/bin/bash
# Initialize The Hive with default admin user and organization

set -e

echo "Waiting for The Hive to be ready..."
sleep 60

echo "Creating The Hive admin user..."

# Create admin user via API
curl -X POST "http://localhost:9000/api/user" \
  -H "Content-Type: application/json" \
  -d '{
    "login": "admin@reactor.local",
    "name": "Administrator",
    "roles": ["superadmin"],
    "password": "ReactorHive123!"
  }'

echo "Creating default organization..."

# Get authentication token first
TOKEN=$(curl -X POST "http://localhost:9000/api/login" \
  -H "Content-Type: application/json" \
  -d '{
    "user": "admin@reactor.local",
    "password": "ReactorHive123!"
  }' | jq -r '.token')

# Create organization
curl -X POST "http://localhost:9000/api/organisation" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "REACTOR",
    "description": "Default REACTOR organization"
  }'

echo "The Hive initialization complete!"