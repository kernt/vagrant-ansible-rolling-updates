#!/bin/bash

sudo apt-get -y install sshpass

ssh-keyscan lb web1 web2 >> ~/.ssh/known_hosts
chown vagrant:vagrant .ssh/known_hosts
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa