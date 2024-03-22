#!/bin/sh

# Install required packages
pkg_add grafana loki

# Create directories for Loki
sudo mkdir -p /var/db/loki/index /var/db/loki/chunks

# Create a Loki configuration file
sudo tee /etc/loki/loki-local-config.yaml > /dev/null <<EOF
auth_enabled: false
server:
  http_listen_port: 3100
EOF

# Enable and start the Loki service
doas rcctl enable loki
doas rcctl start loki

# Add Loki as a data source in Grafana
curl -XPOST -H "Content-Type: application/json" -H "Accept: application/json" -d '{"name":"loki","type":"loki","url":"http://localhost:3100/"}' http://admin:admin@localhost:3000/api/datasources

# Restart Grafana service
doas rcctl restart grafana

echo "Grafana Loki installation and configuration completed."
