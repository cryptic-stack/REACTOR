#!/bin/bash
# Setup Kibana dashboards for REACTOR

set -e

echo "Setting up Kibana dashboards and visualizations..."

# Wait for Kibana to be ready
until curl -u elastic:ReactorElastic123! -s "http://localhost:5601/api/status" > /dev/null; do
    echo "Waiting for Kibana..."
    sleep 5
done

echo "Kibana is ready. Creating index patterns..."

# Create index patterns
curl -X POST "localhost:5601/api/saved_objects/index-pattern/reactor-logs-*" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -H "kbn-xsrf: true" \
  -d '{
    "attributes": {
      "title": "reactor-logs-*",
      "timeFieldName": "@timestamp"
    }
  }'

curl -X POST "localhost:5601/api/saved_objects/index-pattern/reactor-zeek-*" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -H "kbn-xsrf: true" \
  -d '{
    "attributes": {
      "title": "reactor-zeek-*",
      "timeFieldName": "@timestamp"
    }
  }'

echo "Creating basic dashboard..."

# Create a basic security dashboard
curl -X POST "localhost:5601/api/saved_objects/dashboard/reactor-security-overview" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -H "kbn-xsrf: true" \
  -d '{
    "attributes": {
      "title": "REACTOR Security Overview",
      "description": "Main security dashboard for REACTOR SIEM",
      "panelsJSON": "[]",
      "optionsJSON": "{\"hidePanelTitles\":false,\"useMargins\":true,\"syncColors\":false}",
      "version": 1,
      "timeRestore": false,
      "kibanaSavedObjectMeta": {
        "searchSourceJSON": "{\"query\":{\"query\":\"\",\"language\":\"kuery\"},\"filter\":[]}"
      }
    }
  }'

echo "Setting default index pattern..."

# Set default index pattern
curl -X POST "localhost:5601/api/kibana/settings/defaultIndex" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -H "kbn-xsrf: true" \
  -d '{
    "value": "reactor-logs-*"
  }'

echo "Kibana dashboards setup complete!"