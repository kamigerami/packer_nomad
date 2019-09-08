# Nomad - Packer

## Requirements

This packer template is based on Ubuntu. 
The ansible role is tested with the following specific software versions:

* Ansible: 2.8.4-1
* nomad: 0.9.5
* Ubuntu: 18.04
* Packer: 1.4.3

## Packer Environment variables

### `ANSIBLE_VERSION`
- Ansible version we install in the image
- Default value: ***2.8.4-1ppa~bionic***

### `source_box_name`

- Source we base our images on
- Default value: ***ubuntu/bionic64***

### `dest_box_name`

- Name we save our box as
- Default value: ***nomad-server-bionic64***

### `aws_access_key`

- Access key for running in AWS
- Default value: ***empty***

### `aws_secret_key`

- Secret key for running in AWS
- Default value: ***empty***


## Ansible Role Variables

The role defines most of its variables in `defaults/main.yml`:

https://github.com/brianshumate/ansible-nomad/blob/master/defaults/main.yml

### `nomad_version`

- Nomad version to install
- Default value: **0.9.5**

### `nomad_datacenter`

- Nomad datacenter label
- Default value: **dc1**

### `nomad_node_role`

- Nomad node role
- options: *client*, *server*, *both*
- Default value: **client**

### `nomad_docker_enable`

- Install Docker subsystem on nodes?
- Default value: **false**

### `nomad_use_consul`

- Bootstrap nomad via native consul zero-configuration support
  assumes consul default ports etc.
- Default value: **False**

### `nomad_consul_address`

- The address of your consul API, use it in combination with nomad_use_consul=True
- Default value: **localhost:8500**

### `nomad_node_name`

- Nomad node name
- Default value: **nomad**

### `nomad_bind_address`

- Bind interface address
- Default value: **0.0.0.0**

## Dependencies

`ansible`

This directory contains the inventory file and ansible-playbook that gets executed on the remote machine.

`scripts/base.sh`

We install base packages:

```
    unzip curl vim jq netcat \
    zip tar git build-essential python-netaddr \
    apt-transport-https \
    ca-certificates \
    software-properties-common
```

`scripts/ansible.sh`

We install the ansible package on the remote machine and then run the ansible-playbook "locally" on the remote host.

`scripts/install_nomad.sh`

We run the ansible-playbook that install nomad

## Example Playbook

Basic nomad installation is possible using the included `site.yml` playbook:

```
ansible-playbook -i <hosts> site.yml
```

You can also simply pass variables in using the `--extra-vars` option to the
`ansible-playbook` command:

```
ansible-playbook -i hosts site.yml --extra-vars "nomad_datacenter=mydc"
```

## Example running Packer

To build a image with packer you can specify if you want it to build on amazon or using virtualbox by specifying
the `-only=` flag:

```
packer build -only=amazon-ebs -var 'aws_access_key=MYACCESSKEY' -var 'aws_secret_key=MYSECRETKEY' -var 'nomad_datacenter=mydc' templates.json
```

## Example Vagrant

To start a Vagrant cluster with Nomad read the instructions in the [README_VAGRANT.md](vagrant/README_VAGRANT.md) document.
