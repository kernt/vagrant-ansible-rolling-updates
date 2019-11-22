#/bin/bash

PASSWORD="vagrant"

ssh-keyscan lb web1 web2 >> ~/.ssh/known_hosts
chown vagrant:vagrant .ssh/known_hosts

sshpass -p $PASSWORD ssh-copy-id -o StrictHostKeyChecking=no lb
sshpass -p $PASSWORD ssh-copy-id -o StrictHostKeyChecking=no web1
sshpass -p $PASSWORD ssh-copy-id -o StrictHostKeyChecking=no web2