#!/bin/bash
set -ex

logger() {
  DT=$(date '+%Y/%m/%d %H:%M:%S')
  echo "$DT base.sh: $1"
}

logger "Executing"

logger "Update the box"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y unzip curl vim jq netcat \
    zip tar git build-essential python-netaddr \
    apt-transport-https \
    ca-certificates \
    software-properties-common

logger "Complete"
