#!/usr/bin/env bash

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo echo '      nameservers:' >> /etc/netplan/50-vagrant.yaml
sudo echo '        addresses:' >> /etc/netplan/50-vagrant.yaml
sudo echo '        - 8.8.8.8' >> /etc/netplan/50-vagrant.yaml

netplan apply

systemctl restart systemd-resolved

# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL

# vagrant environment nodes
10.0.15.10  mgmt
10.0.15.11  lb
10.0.15.21  web1
10.0.15.22  web2
10.0.15.23  web3
10.0.15.24  web4
10.0.15.25  web5
10.0.15.26  web6
10.0.15.27  web7
10.0.15.28  web8
10.0.15.29  web9
EOL

apt-get update
apt-get -y install mc vim git