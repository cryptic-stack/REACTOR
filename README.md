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

1. Build and start all services:
   ```bash
   docker-compose up -d
   ```

2. Access the Kibana dashboard:
   ```
   http://localhost
   ```

3. Access Elasticsearch directly (for debugging):
   ```
   http://localhost/elasticsearch/
   ```

4. Stop all services:
   ```bash
   docker-compose down
   ```

### Architecture

Each Docker container is organized in its own folder with:
- `Dockerfile` - Container build instructions
- Configuration files specific to that service
- Service-specific documentation

The `docker-compose.yml` orchestrates all services with proper networking, health checks, and dependencies.
