#!/bin/bash

# REACTOR SIEM Startup Script
# This script helps you get started with the REACTOR SIEM stack

set -e

echo "🔧 REACTOR SIEM - Portable SIEM Docker Stack"
echo "=============================================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if Docker Compose is available
if ! docker compose version > /dev/null 2>&1; then
    echo "❌ Docker Compose is not available. Please install Docker Compose."
    exit 1
fi

echo "✅ Docker is running"
echo "✅ Docker Compose is available"
echo ""

# Show services that will be started
echo "🚀 Starting REACTOR SIEM services:"
echo "   - Elasticsearch (port 9200) - Log storage and search"
echo "   - Logstash (ports 5044, 5000) - Log processing"
echo "   - Kibana (port 5601) - Visualization dashboard"
echo "   - Filebeat - Log shipping agent"
echo "   - Nginx (port 80) - Reverse proxy"
echo ""

# Start the stack
echo "🔄 Building and starting services..."
docker compose up -d

echo ""
echo "⏳ Waiting for services to be healthy..."
sleep 10

# Check service status
echo ""
echo "📊 Service Status:"
docker compose ps

echo ""
echo "🎉 REACTOR SIEM is starting up!"
echo ""
echo "📍 Access points:"
echo "   - Kibana Dashboard: http://localhost"
echo "   - Kibana Direct: http://localhost:5601"
echo "   - Elasticsearch API: http://localhost/elasticsearch/"
echo ""
echo "📝 Useful commands:"
echo "   - View logs: docker compose logs -f [service]"
echo "   - Stop stack: docker compose down"
echo "   - Restart stack: docker compose restart"
echo ""
echo "⚠️  Note: It may take a few minutes for all services to be fully operational."