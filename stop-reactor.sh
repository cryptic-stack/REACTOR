#!/bin/bash

# REACTOR SIEM Stop Script
# This script safely stops the REACTOR SIEM stack

set -e

echo "🛑 REACTOR SIEM - Stopping Services"
echo "==================================="

# Stop the services
echo "⏹️  Stopping all REACTOR SIEM services..."
docker compose down

echo ""
echo "📊 Final status:"
docker compose ps

echo ""
echo "✅ REACTOR SIEM has been stopped."
echo ""
echo "💡 To remove all data volumes as well, run:"
echo "   docker compose down -v"
echo ""
echo "💡 To start again, run:"
echo "   ./start-reactor.sh"