#!/bin/bash
set -ex

logger() {
  DT=$(date '+%Y/%m/%d %H:%M:%S')
  echo "$DT install_nomad.sh: $1"
}

logger "Executing"

logger "Install ansible-galaxy role for nomad"

ansible-galaxy install brianshumate.nomad

logger "run ansible-playbook"

ansible-playbook -i /tmp/$1/hosts \
    --connection=local \
    -e nomad_version=${ANSIBLE_NOMAD_VERSION} \
    -e nomad_node_role=${ANSIBLE_NOMAD_NODE_ROLE} \
    -e nomad_datacenter=${ANSIBLE_NOMAD_DATACENTER} \
    -e nomad_docker_enable=${ANSIBLE_NOMAD_DOCKER_ENABLE} \
    -e nomad_use_consul=${ANSIBLE_NOMAD_USE_CONSUL} \
    -e nomad_disable_update_check=${ANSIBLE_NOMAD_DISABLE_UPDATE_CHECK} \
    -e nomad_consul_address=${ANSIBLE_NOMAD_CONSUL_ADDRESS} \
    -e nomad_node_name=${ANSIBLE_NOMAD_NODE_NAME} \
    -e nomad_bind_address=${ANSIBLE_NOMAD_BIND_ADDRESS} \
    /tmp/$1/site.yml