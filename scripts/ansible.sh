#!/bin/bash
set -ex

logger() {
  DT=$(date '+%Y/%m/%d %H:%M:%S')
  echo "$DT ansible.sh: $1"
}

logger "Executing"

logger "Add ansible repository"
apt-add-repository ppa:ansible/ansible

logger "Install Ansible"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ansible=$1