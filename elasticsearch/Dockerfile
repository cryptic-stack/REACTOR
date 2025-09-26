FROM elasticsearch:8.11.0

# Set environment variables
ENV discovery.type=single-node
ENV xpack.security.enabled=false
ENV xpack.security.enrollment.enabled=false

# Configure Elasticsearch
COPY elasticsearch.yml /usr/share/elasticsearch/config/

# Expose port
EXPOSE 9200 9300

# Set proper permissions
USER elasticsearch