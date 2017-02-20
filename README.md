# Vagrant and Chef Server
I created this Vagrantfile and the necessary Bash scripts because I wanted to test and play around with Chef and Chef Server, but I couldn't find any ready-made resources for that, so I made my own. The Bash scripts aren't the most elegant, but I have found it can get me up and running fairly quickly considering the alternatives of manually running everything.

# Usage instructions
## Setting up the VMs

You can set up all the VMs in one go by executing:

`vagrant up`

This will create the VMs in the order they are defined in the Vagrantfile, namely *ws*, *chefsrv*, and *test*. If you want to set them individually, then do so by executing:

`vagrant up [VM name]`

where **VM name** is an optional argument and can be either *ws*, *chefsrv* or *test*. It can be useful for debugging purposes to start up an individual VM, but for things to properly work *chefsrv* needs to be created before *ws* as the run scripts for *ws* depend on the Chef Server virtual machine being active and set up.

Once the VMs have been set up you can access them either via a regular `ssh` command or through `vagrant ssh <VM name>`. The regular `ssh` command requires you to know which ports the VMs are listening on; executing the following will show you that information:

`vagrant ssh-config [VM name]`

where **VM name** is an optional argument and can be either *ws*, *chefsrv* or *test*.

If the previous command ran successfully you are ready to bootstrap the node from the *ws* instance:

`cd chef-repo/`
`sudo knife bootstrap 10.0.15.12 -N test -x vagrant -P vagrant --sudo --use-sudo-pass`

You might get an error about a failure to read the private key, so make sure you are inside the **~/chef-repo/** directory!

## Finishing your work
Once you are finished, exit out of the hosts you are working on and run:

`vagrant halt [VM name]`

where **VM name** is an optional argument and can be either *ws*, *chefsrv* or *test*. Running this will shut down the machine Vagrant is managing.

If you wish to completely destroy the hosts and all the data:

`vagrant destroy [VM name]`

where **VM name** is an optional argument and can be either *ws*, *chefsrv* or *test*.

# Change Log
All notable changes to this project will be documented in this section. Inspired by [Keep a CHANGELOG](http://keepachangelog.com/).

## [Unreleased]
### Changed
- TBD

## [0.0.3] – 2017-02-20
### Changed
- Reduced the number of commands users have to input after Vagrant finishes `vagrant up`
- Testing node named from *node* to *test* to minimize confusion with basic `knife` commands where the keyword "node" is prevalent

### Added
- More information to README.md

## [0.0.2] – 2017-01-14
### Changed
- Vagrantfile includes Ubuntu 16.04 box instead of deprecated Wheezy box
- Bash scripts point to newer version of Chef Server and Chef Development Kit
- Chef Server and workstation run commands no longer reference non-existing .pem file

## [0.0.1] – 2016-05-28
### Added
- Basic Vagrantfile and Bash scripts for setting up a workstation, Chef Server and a node.
- A README.md for an overview
