#!/bin/bash
# Initialize Cortex with default admin user

set -e

echo "Waiting for Cortex to be ready..."
sleep 60

echo "Creating Cortex admin user..."

# Create admin user via API
curl -X POST "http://localhost:9001/api/maintenance/migrate" \
  -H "Content-Type: application/json"

# Create first superadmin user
curl -X POST "http://localhost:9001/api/user" \
  -H "Content-Type: application/json" \
  -d '{
    "login": "admin@reactor.local",
    "name": "Administrator",
    "roles": ["superadmin"],
    "password": "ReactorCortex123!"
  }'

echo "Creating default organization..."

# Get authentication token
TOKEN=$(curl -X POST "http://localhost:9001/api/login" \
  -H "Content-Type: application/json" \
  -d '{
    "user": "admin@reactor.local",
    "password": "ReactorCortex123!"
  }' | jq -r '.token')

# Create organization
curl -X POST "http://localhost:9001/api/organisation" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "REACTOR",
    "description": "Default REACTOR organization"
  }'

echo "Cortex initialization complete!"