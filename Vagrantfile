# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	# Create Chef server
	# System requirements: https://docs.chef.io/chef_system_requirements.html
	config.vm.define :chefsrv do |chefsrv_config|
		chefsrv_config.vm.box = "puphpet/ubuntu1604-x64"
		chefsrv_config.vm.hostname = "chefsrv"
		chefsrv_config.vm.network :private_network, ip: "10.0.15.10"
		chefsrv_config.vm.network "forwarded_port", guest: 80, host: 8080
		chefsrv_config.vm.provider "virtualbox" do |vb|
			vb.memory = "4096"
		end
		chefsrv_config.vm.provision :shell, path: "rc/chefsrv.sh"
	end

	# Create workstation
	config.vm.define :ws do |ws_config|
		ws_config.vm.box = "puphpet/ubuntu1604-x64"
		ws_config.vm.hostname = "ws"
		ws_config.vm.network :private_network, ip: "10.0.15.11"
		ws_config.vm.provider "virtualbox" do |vb|
			vb.memory = "258"
		end
		ws_config.vm.provision :shell, path: "rc/ws.sh"
	end

	# Create Ubuntu node
	config.vm.define :test do |test_config|
		test_config.vm.box = "puphpet/ubuntu1604-x64"
		test_config.vm.hostname = "test"
		test_config.vm.network :private_network, ip: "10.0.15.12"
		test_config.vm.network "forwarded_port", guest: 80, host: 8081
		test_config.vm.provider "virtualbox" do |vb|
			vb.memory = "512"
		end
		test_config.vm.provision :shell, path: "rc/test.sh"
	end
	
end
