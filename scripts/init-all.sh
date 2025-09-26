#!/bin/bash
# Master initialization script for REACTOR SIEM

set -e

echo "=========================================="
echo "Starting REACTOR SIEM Initialization"
echo "=========================================="

# Make all scripts executable
chmod +x scripts/*.sh

echo "Step 1: Initializing Elasticsearch..."
./scripts/init-elastic.sh

echo "Step 2: Initializing Arkime..."
./scripts/init-arkime.sh

echo "Step 3: Initializing The Hive..."
./scripts/init-thehive.sh

echo "Step 4: Initializing Cortex..."
./scripts/init-cortex.sh

echo "Step 5: Setting up Kibana dashboards..."
./scripts/setup-kibana-dashboards.sh

echo "=========================================="
echo "REACTOR SIEM Initialization Complete!"
echo "=========================================="
echo
echo "Access URLs:"
echo "- Main Dashboard: https://localhost"
echo "- Kibana: https://kibana.reactor.local"
echo "- The Hive: https://thehive.reactor.local" 
echo "- MISP: https://misp.reactor.local"
echo "- Caldera: https://caldera.reactor.local"
echo "- Arkime: https://arkime.reactor.local"
echo "- RabbitMQ Management: http://localhost:15672"
echo
echo "Default Credentials:"
echo "- Elasticsearch: elastic / ReactorElastic123!"
echo "- Kibana: elastic / ReactorElastic123!"
echo "- The Hive: admin@reactor.local / ReactorHive123!"
echo "- Cortex: admin@reactor.local / ReactorCortex123!"
echo "- MISP: admin@reactor.local / ReactorMisp123!"
echo "- Caldera Red: red / ReactorCalderaRed123!"
echo "- Caldera Blue: blue / ReactorCalderaBlue123!"
echo "- Arkime: admin / ReactorArkime123!"
echo "- RabbitMQ: reactor / ReactorRabbit123!"
echo
echo "Add these entries to your /etc/hosts file:"
echo "127.0.0.1 reactor.local"
echo "127.0.0.1 kibana.reactor.local"
echo "127.0.0.1 thehive.reactor.local"
echo "127.0.0.1 misp.reactor.local"
echo "127.0.0.1 caldera.reactor.local"
echo "127.0.0.1 arkime.reactor.local"