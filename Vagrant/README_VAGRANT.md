# Nomad in Vagrant

This project provides documentation and a collection of scripts to help you
automate the deployment of [Nomad](https://nomadproject.io) using
[Ansible](http://www.ansible.com/). These are the instructions for
deploying a cluster on Vagrant and VirtualBox.

The documentation and scripts are a starting point to quickly bootstrap an
environment for development.

## Vagrant Development Cluster

In some situations deploying a small cluster on your local development
machine can be handy. This document describes such a scenario using the
following technologies:

* [Nomad](https://nomadproject.io)
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](http://www.vagrantup.com/) with Ansible provisioner and
  supporting plugin
* [Ansible](http://www.ansible.com/)

Each of the virtual machines for this guide are configured with
1.5GB RAM, 2 CPU cores, and 2 network interfaces. The first interface uses
NAT and has connection via the host to the outside world. The second
interface is a private network and is used for nomad intra-cluster
communication in addition to access from the host machine.

The Vagrant configuration file (`Vagrantfile`) is responsible for
configuring the virtual machines and a baseline OS installation
using scripts located in the directory `./../script`.

The Ansible playbooks then further refine OS configuration, perform nomad
software download and installation, and the initialization of nodes
into a ready to use cluster.

## Designed for Ansible Galaxy

The role we use to install nomad is designed to be installed via the `ansible-galaxy` command.

The project can be found here: https://github.com/brianshumate/ansible-nomad

You should install it like this:

```
ansible-galaxy install brianshumate.nomad
```

## Quick Start

Begin from the top level directory of this project and use the following
steps to get up and running:

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads), [Vagrant](http://downloads.vagrantup.com/)
2. cd `vagrant`
3. `vagrant up`

By default, this project will install ubuntu bionic64 based cluster nodes.

## Notes

1. This project functions with the following software versions:
  * Nomad version 0.9.5
  * Ansible version 2.8.4
  * VirtualBox version 6.0
  * Vagrant version 2.2.4
2. This project uses ubuntu/bionic64 by default.
3. The `bin/preinstall` shell script performs the following actions for you:
 * Adds each node's host information to the host machine's `/etc/hosts`
 * Optionally installs the Vagrant hosts plugin

## References

1. https://www.nomadproject.io/
2. http://www.ansible.com/
3. http://www.vagrantup.com/
4. https://www.virtualbox.org/
5. https://github.com/brianshumate/ansible-nomad
