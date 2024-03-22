#!/bin/bash

# Update package index
sudo apt update

# Install Fluentd dependencies
sudo apt install -y ruby ruby-dev build-essential

# Install Fluentd gem
sudo gem install fluentd

# Install td-agent (Fluentd package for Ubuntu)
curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-focal-td-agent4.sh | sh

# Start and enable td-agent service
sudo systemctl start td-agent
sudo systemctl enable td-agent

# Install Fluentd plugin for Elasticsearch
sudo /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch

# Configure Fluentd to forward logs to Elasticsearch
cat <<EOF | sudo tee /etc/td-agent/td-agent.conf
<source>
  @type forward
</source>

<match **>
  @type elasticsearch
  host localhost
  port 9200
  logstash_format true
  flush_interval 5s
</match>
EOF

# Restart td-agent service to apply configuration changes
sudo systemctl restart td-agent
