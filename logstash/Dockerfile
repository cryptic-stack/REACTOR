FROM logstash:8.11.0

# Copy configuration files
COPY logstash.yml /usr/share/logstash/config/
COPY pipeline/ /usr/share/logstash/pipeline/

# Expose port
EXPOSE 5044 5000 9600

# Run as logstash user
USER logstash