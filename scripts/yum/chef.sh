#!/bin/bash -eux
#
#
DISTRIBUTION=$(cat /etc/*-release | grep "^ID=" | cut -d "=" -f 2)
CHANNEL="stable"

# Add Repo for Chef


# Install Chef dependencies.
apt -y update && apt-get -y upgrade
apt -y install apt-transport-https
wget -qO - https://packages.chef.io/chef.asc | apt-key add -
echo "deb https://packages.chef.io/repos/apt/${CHANNEL} ${DISTRIBUTION} main" > chef-<CHANNEL>.list

apt -y install chef

# Install Ansible.
pip install ansible