#!/bin/bash
NODENAME="web"

for i in {1..4}
  do vagrant ssh ${NODENAME}$i -c 'sudo /vagrant/ssh_setup.sh'
done
