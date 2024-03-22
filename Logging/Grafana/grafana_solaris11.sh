#!/bin/sh

# Install Node.js (required for Grafana)
pkg install developer/nodejs

# Download and extract Grafana
wget https://dl.grafana.com/oss/release/grafana-8.0.6.linux-amd64.tar.gz
tar -zxvf grafana-8.0.6.linux-amd64.tar.gz

# Move Grafana to /opt
mv grafana-8.0.6 /opt/grafana

# Configure Grafana to listen on all interfaces
sed -i 's/;http_addr =.*/http_addr = 0.0.0.0/' /opt/grafana/conf/defaults.ini

# Start Grafana service
/opt/grafana/bin/grafana-server --config=/opt/grafana/conf/defaults.ini --homepath=/opt/grafana

# Enable Grafana service to start on boot (optional)
echo "/opt/grafana/bin/grafana-server --config=/opt/grafana/conf/defaults.ini --homepath=/opt/grafana" >> /etc/rc.local
chmod +x /etc/rc.local
