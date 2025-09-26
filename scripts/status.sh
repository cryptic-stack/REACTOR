#!/bin/bash
# Check REACTOR SIEM status

set -e

echo "REACTOR SIEM Status"
echo "==================="
echo

# Check if docker-compose services are running
if docker-compose ps | grep -q "Up"; then
    echo "Docker Services:"
    docker-compose ps
    echo
    
    echo "Service Health Checks:"
    echo "---------------------"
    
    # Check Elasticsearch
    echo -n "Elasticsearch: "
    if curl -u elastic:ReactorElastic123! -s "http://localhost:9200/_cluster/health" > /dev/null 2>&1; then
        echo "✓ Healthy"
    else
        echo "✗ Unhealthy"
    fi
    
    # Check Kibana
    echo -n "Kibana: "
    if curl -s "http://localhost:5601/api/status" > /dev/null 2>&1; then
        echo "✓ Healthy"
    else
        echo "✗ Unhealthy"
    fi
    
    # Check The Hive
    echo -n "The Hive: "
    if curl -s "http://localhost:9000/api/status" > /dev/null 2>&1; then
        echo "✓ Healthy"
    else
        echo "✗ Unhealthy"
    fi
    
    # Check MISP
    echo -n "MISP: "
    if curl -s "http://localhost:8080" > /dev/null 2>&1; then
        echo "✓ Healthy"
    else
        echo "✗ Unhealthy"
    fi
    
    # Check Caldera
    echo -n "Caldera: "
    if curl -s "http://localhost:8888" > /dev/null 2>&1; then
        echo "✓ Healthy"
    else
        echo "✗ Unhealthy"
    fi
    
    # Check RabbitMQ
    echo -n "RabbitMQ: "
    if curl -s "http://localhost:15672" > /dev/null 2>&1; then
        echo "✓ Healthy"
    else
        echo "✗ Unhealthy"
    fi
    
    echo
    echo "Access URLs:"
    echo "- Main Dashboard: https://localhost"
    echo "- Kibana: https://kibana.reactor.local"
    echo "- The Hive: https://thehive.reactor.local"
    echo "- MISP: https://misp.reactor.local"
    echo "- Caldera: https://caldera.reactor.local"
    echo "- Arkime: https://arkime.reactor.local"
    echo "- RabbitMQ: http://localhost:15672"
    
else
    echo "REACTOR SIEM is not running."
    echo "Start it with: ./scripts/start.sh"
fi