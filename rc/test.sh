#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install vim tree git > /dev/null

# Populate hosts file for easy testing
cat >> /etc/hosts <<EOL
# Vagrant environment nodes
10.0.15.10  chefsrv
10.0.15.11  ws
10.0.15.12  test
EOL