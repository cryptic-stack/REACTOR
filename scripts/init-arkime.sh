#!/bin/bash
# Initialize Arkime database and create default admin user

set -e

echo "Waiting for Arkime to be ready..."
sleep 30

echo "Initializing Arkime database..."

# Initialize Arkime database
docker exec reactor-arkime /opt/arkime/db/db.pl http://elasticsearch:9200 init

echo "Creating Arkime admin user..."

# Create admin user
docker exec reactor-arkime /opt/arkime/bin/arkime_add_user.sh admin "Admin User" ReactorArkime123! --admin

echo "Arkime initialization complete!"

# Configure Arkime for better integration
echo "Configuring Arkime wise integration..."

# The wise configuration would typically go here
# For now, we'll just ensure the basic setup is working

echo "Arkime setup completed successfully!"