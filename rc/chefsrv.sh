#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install vim tree git > /dev/null

# Grab the latest version of Chef Server from: https://downloads.chef.io/chef-server/
wget https://packages.chef.io/files/stable/chef-server/12.11.1/ubuntu/14.04/chef-server-core_12.11.1-1_amd64.deb

# Install the package
sudo dpkg -i chef-server-core_*.deb

# Configure environment-specific components
sudo chef-server-ctl reconfigure

# Create administrative user
# chef-server-ctl user-create USERNAME FIRST_NAME LAST_NAME EMAIL PASSWORD -f <name of new user's private key>.pem
# -f is used to output new user's private RSA key, which will be used for "knife" command authentication
sudo chef-server-ctl user-create admin Adminy McAdminface admin@example.com examplepass -f admin.pem

# Create organization
# chef-server-ctl org-create SHORTNAME LONGNAME --association_user USERNAME -f <name of validator>.pem
# --association_user specifies the username that has access to administer the organization
# -f is used to output the validator private RSA key, which will be used for validating new clients until they get their own client key
sudo chef-server-ctl org-create admincorp "AdminCorp, Inc." --association_user admin -f user-admin-validator.pem

# Populate hosts file for easy testing
cat >> /etc/hosts <<EOL
# Vagrant environment nodes
10.0.15.10  chefsrv
10.0.15.11  ws
10.0.15.12  test
EOL
