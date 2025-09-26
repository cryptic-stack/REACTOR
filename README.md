# REACTOR
Repo for testing AI code helper / creating a docker project for portable SIEM

## Docker Container Architecture

This project implements a containerized SIEM (Security Information and Event Management) solution with each service in its own dedicated folder:

### Services

- **elasticsearch/** - Log storage and search engine
- **logstash/** - Log processing and ingestion pipeline
- **kibana/** - Web-based visualization dashboard
- **filebeat/** - Log shipping agent
- **nginx/** - Reverse proxy for web access

### Quick Start

#### Option 1: Using convenience scripts (Recommended)
```bash
# Start the entire SIEM stack
./start-reactor.sh

# Stop the SIEM stack
./stop-reactor.sh
```

#### Option 2: Using Docker Compose directly
```bash
# Build and start all services
docker-compose up -d

# Stop all services
docker-compose down
```

### Access Points

- **Kibana Dashboard**: http://localhost (main interface)
- **Kibana Direct**: http://localhost:5601
- **Elasticsearch API**: http://localhost/elasticsearch/ (for debugging)

### Architecture

Each Docker container is organized in its own folder with:
- `Dockerfile` - Container build instructions
- Configuration files specific to that service
- Service-specific documentation

The `docker-compose.yml` orchestrates all services with proper networking, health checks, and dependencies.
