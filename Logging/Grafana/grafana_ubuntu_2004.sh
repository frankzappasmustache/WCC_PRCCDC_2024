#!/bin/bash

# Add Grafana repository
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

# Import Grafana GPG key
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

# Update package index
sudo apt-get update

# Install Grafana
sudo apt-get install -y grafana

# Start and enable Grafana service
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

# Open port 3000 in firewall
sudo ufw allow 3000/tcp

# Configure Grafana to listen on all interfaces (optional, use with caution)
sudo sed -i 's/;http_addr =.*/http_addr = 0.0.0.0/' /etc/grafana/grafana.ini

# Restart Grafana service to apply configuration changes
sudo systemctl restart grafana-server
