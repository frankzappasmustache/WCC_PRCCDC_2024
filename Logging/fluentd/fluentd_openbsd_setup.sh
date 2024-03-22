#!/bin/sh

# Update package index
pkg_add -u

# Install Fluentd dependencies
pkg_add -r ruby
pkg_add -r gcc
pkg_add -r gmake
pkg_add -r libtool

# Install Fluentd gem
gem install fluentd

# Install Fluentd plugin for Elasticsearch
gem install fluent-plugin-elasticsearch

# Configure Fluentd to forward logs to Elasticsearch
cat <<EOF > /etc/fluent/fluent.conf
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

# Start Fluentd service
fluentd -c /etc/fluent/fluent.conf
