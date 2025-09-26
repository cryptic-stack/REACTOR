#!/bin/bash
# Initialize Elasticsearch with users and roles for REACTOR

set -e

echo "Waiting for Elasticsearch to be ready..."
until curl -u elastic:ReactorElastic123! -s "http://localhost:9200/_cluster/health" > /dev/null; do
    echo "Waiting for Elasticsearch..."
    sleep 5
done

echo "Elasticsearch is ready. Setting up users and roles..."

# Create kibana_system user password
curl -X POST "localhost:9200/_security/user/kibana_system/_password" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -d '{"password": "ReactorKibanaSystem123!"}'

# Create logstash_writer role
curl -X POST "localhost:9200/_security/role/logstash_writer" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -d '{
    "cluster": ["manage_index_templates", "monitor", "manage_ilm"],
    "indices": [
      {
        "names": ["reactor-*"],
        "privileges": ["write", "create", "create_index", "manage", "manage_ilm"]
      }
    ]
  }'

# Create logstash_internal user
curl -X POST "localhost:9200/_security/user/logstash_internal" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -d '{
    "password": "ReactorLogstash123!",
    "roles": ["logstash_writer"],
    "full_name": "Internal Logstash User"
  }'

# Create arkime role
curl -X POST "localhost:9200/_security/role/arkime_role" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -d '{
    "cluster": ["manage"],
    "indices": [
      {
        "names": ["arkime_*", "sessions*", "fields*", "dstats*", "sequence*", "files*", "hunts*", "lookups*", "queries*", "stats*", "users*"],
        "privileges": ["all"]
      }
    ]
  }'

# Create arkime user
curl -X POST "localhost:9200/_security/user/arkime_user" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -d '{
    "password": "ReactorArkime123!",
    "roles": ["arkime_role"],
    "full_name": "Arkime Service User"
  }'

# Create zeek role
curl -X POST "localhost:9200/_security/role/zeek_role" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -d '{
    "cluster": ["manage_index_templates", "monitor", "manage_ilm"],
    "indices": [
      {
        "names": ["reactor-zeek-*"],
        "privileges": ["write", "create", "create_index", "manage"]
      }
    ]
  }'

# Create zeek user  
curl -X POST "localhost:9200/_security/user/zeek_user" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -d '{
    "password": "ReactorZeek123!",
    "roles": ["zeek_role"],
    "full_name": "Zeek Service User"
  }'

echo "Elasticsearch users and roles created successfully!"

# Create index templates
echo "Creating index templates..."

# Reactor logs template
curl -X PUT "localhost:9200/_index_template/reactor-logs" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -d '{
    "index_patterns": ["reactor-logs-*"],
    "template": {
      "settings": {
        "number_of_shards": 1,
        "number_of_replicas": 0,
        "index.refresh_interval": "30s"
      },
      "mappings": {
        "properties": {
          "@timestamp": {"type": "date"},
          "message": {"type": "text"},
          "host": {"type": "keyword"},
          "level": {"type": "keyword"}
        }
      }
    }
  }'

# Zeek logs template
curl -X PUT "localhost:9200/_index_template/reactor-zeek" \
  -u elastic:ReactorElastic123! \
  -H "Content-Type: application/json" \
  -d '{
    "index_patterns": ["reactor-zeek-*"],
    "template": {
      "settings": {
        "number_of_shards": 1,
        "number_of_replicas": 0,
        "index.refresh_interval": "30s"
      },
      "mappings": {
        "properties": {
          "@timestamp": {"type": "date"},
          "ts": {"type": "date"},
          "uid": {"type": "keyword"},
          "id_orig_h": {"type": "ip"},
          "id_resp_h": {"type": "ip"},
          "id_orig_p": {"type": "integer"},
          "id_resp_p": {"type": "integer"},
          "proto": {"type": "keyword"}
        }
      }
    }
  }'

echo "Index templates created successfully!"
echo "Elasticsearch initialization complete!"