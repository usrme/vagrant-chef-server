#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install vim tree git sshpass > /dev/null

# Clone Chef repository
git clone https://github.com/chef/chef-repo.git

# Make sure Git ignores the contents of the .chef directory
echo ".chef" >> /home/vagrant/chef-repo/.gitignore

# Grab the latest version of Chef Development Kit (DK): https://downloads.chef.io/chef-dk/
wget https://packages.chef.io/files/stable/chefdk/1.1.16/ubuntu/16.04/chefdk_1.1.16-1_amd64.deb

# Install the package
sudo dpkg -i chefdk_*.deb

# Default to the version of Ruby installed with Chef
echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
source ~/.bash_profile

# Navigate to the proper directory
cd /home/vagrant/chef-repo
# Create hidden directory for keys and Knife configuration
sudo mkdir .chef

# Populate Knife configuration according to chefsrv.sh
# node_name is the same as the "association_user" from "chefsrv.sh"
cat >> /home/vagrant/chef-repo/.chef/knife.rb <<EOL
current_dir = File.dirname(__FILE__)
log_level                	:info
log_location             	STDOUT
node_name                	"admin"
client_key               	"#{current_dir}/admin.pem"
validation_client_name   	"admincorp-validator"
validation_key           	"#{current_dir}/admincorp-validator.pem"
chef_server_url          	"https://chefsrv/organizations/admincorp"
syntax_check_cache_path  	"#{ENV['HOME']}/.chef/syntaxcache"
cookbook_path            	["#{current_dir}/../cookbooks"]
encrypted_data_bag_secret	"/etc/chef/encrypted_data_bag_secret"
EOL

# Populate hosts file for easy testing
cat >> /etc/hosts <<EOL
# Vagrant environment nodes
10.0.15.10  chefsrv
10.0.15.11  ws
10.0.15.12  node
EOL

# Copy over private key and validation key
sudo sshpass -p "vagrant" scp -o StrictHostKeyChecking=no -q vagrant@chefsrv:/home/vagrant/admin.pem /home/vagrant/chef-repo/.chef/
sudo sshpass -p "vagrant" scp -o StrictHostKeyChecking=no -q vagrant@chefsrv:/home/vagrant/user-admin-validator.pem /home/vagrant/chef-repo/.chef/

# Change ownership of the chef-repo directory from "root" to "vagrant"
sudo chown -R vagrant:vagrant /home/vagrant/chef-repo/