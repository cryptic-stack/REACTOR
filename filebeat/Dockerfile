FROM elastic/filebeat:8.11.0

# Copy configuration
COPY filebeat.yml /usr/share/filebeat/filebeat.yml

# Set proper permissions
USER root
RUN chown root:filebeat /usr/share/filebeat/filebeat.yml
RUN chmod go-w /usr/share/filebeat/filebeat.yml

USER filebeat