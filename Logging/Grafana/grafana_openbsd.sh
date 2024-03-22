#!/bin/sh

# Update package index
pkg_add -u

# Install Grafana dependencies
pkg_add node

# Download and extract Grafana
wget https://dl.grafana.com/oss/release/grafana-8.0.6.linux-amd64.tar.gz
tar -zxvf grafana-8.0.6.linux-amd64.tar.gz

# Move Grafana to /usr/local
mv grafana-8.0.6 /usr/local/grafana

# Create a symbolic link
ln -s /usr/local/grafana/bin/grafana-server /usr/local/bin/grafana-server

# Configure Grafana to listen on all interfaces
sed -i 's/;http_addr =.*/http_addr = 0.0.0.0/' /usr/local/grafana/conf/defaults.ini

# Start Grafana service
/usr/local/bin/grafana-server --config=/usr/local/grafana/conf/defaults.ini --homepath=/usr/local/grafana

# Enable Grafana service to start on boot (optional)
echo "/usr/local/bin/grafana-server --config=/usr/local/grafana/conf/defaults.ini --homepath=/usr/local/grafana" >> /etc/rc.local
chmod +x /etc/rc.local
