#!/bin/bash

# Add Loki repository and key
sudo apt-get update && sudo apt-get install -y curl
curl -s https://packagecloud.io/install/repositories/grafana/loki/script.deb.sh | sudo bash

# Install Loki
sudo apt-get install -y loki

# Configure Loki
sudo tee /etc/loki/local-config.yaml > /dev/null <<EOF
auth_enabled: false
server:
  http_listen_port: 3100
EOF

# Enable and start Loki service
sudo systemctl enable loki
sudo systemctl start loki

# Install and configure Grafana
sudo apt-get install -y grafana
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

# Add Loki as a data source in Grafana
curl -XPOST -H "Content-Type: application/json" -H "Accept: application/json" -d '{"name":"loki","type":"loki","url":"http://localhost:3100/"}' http://admin:admin@localhost:3000/api/datasources

# Restart Grafana service
sudo systemctl restart grafana-server

echo "Grafana Loki installation and configuration completed."
