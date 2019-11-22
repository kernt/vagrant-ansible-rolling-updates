#!/usr/bin/env bash
PASSWORD="vagrant"

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo echo '      nameservers:' >> /etc/netplan/50-vagrant.yaml
sudo echo '        addresses:' >> /etc/netplan/50-vagrant.yaml
sudo echo '        - 8.8.8.8' >> /etc/netplan/50-vagrant.yaml

netplan apply

systemctl restart systemd-resolved

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible mc vim git ansible-lint ansible-test aptitude sshpass

# copy examples into /home/vagrant (from inside the mgmt node)
cp -a /vagrant/examples/* /home/vagrant
chown -R vagrant:vagrant /home/vagrant

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

rm -f /etc/ansible/hosts
ln -s /home/vagrant/inventory.ini /etc/ansible/hosts

mv /etc/ansible.cfg /etc/ansible.backup
cp /home/vagrant/ansible.cfg /etc/ansible/

cd ~

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

cd -