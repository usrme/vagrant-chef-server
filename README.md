# Vagrant and Chef Server
I created this Vagrantfile and the necessary Bash scripts because I wanted to test and play around with Chef and Chef Server, but I couldn't find any ready-made resources for that, so I made my own. The Bash scripts aren't the most elegant, but I have found it can get me up and running fairly quickly considering the alternatives of manually running everything.

# Usage instructions
## Setting everything up
Set up hosts:

`vagrant up <host name>`

where **host name** is an optional paramater and can be either *ws*, *chefsrv* or *node*. It can be useful for debugging purposes to start up an individual host.

Once the hosts have been set up:

`vagrant ssh-config <host name>`

where **host name** is an optional paramater and can be either *ws*, *chefsrv* or *node*. Running this command will show the SSH configuration for each host and with this information you can SSH into the guest with other terminal emulators that don't necessarily accept (or have an option for) executable-specific commands such as Vagrant's own SSH command.

SSH into the host through whatever means you wish, my go-to is:

`ssh vagrant@127.0.0.1 -p <port>`

where **port** is the port number indicated from the output of the previous command.

Once inside the guest host:

`cd chef-repo/.chef/`

`sudo knife ssl fetch`

which will navigate you to the correct directory and add the Chef Server's certificate files to a list inside the .chef directory.

If the previous command ran successfully you are ready to bootstrap the node:

`sudo knife bootstrap 10.0.15.12 -N node -x vagrant -P vagrant --sudo --use-sudo-pass`

## Finishing your work
Once you are finished, exit out of the hosts you are working on and run:

`vagrant halt <host name>`

where **host name** is an optional paramater and can be either *ws*, *chefsrv* or *node*. Running this will shut down the machine Vagrant is managing.

If you wish to completely destroy the hosts and all the data:

`vagrant destroy <host name>`

where **host name** is an optional paramater and can be either *ws*, *chefsrv* or *node*.

# Change Log
All notable changes to this project will be documented in this section. Inspired by [Keep a CHANGELOG](http://keepachangelog.com/).

## [Unreleased]
### Changed
- Minimize the number of commands users have to input after Vagrant finishes `up`
- Add more information to README.md

## [0.0.1] – 2016-05-28
### Added
- Basic Vagrantfile and Bash scripts for setting up a workstation, Chef Server and a node.
- A README.md for an overview