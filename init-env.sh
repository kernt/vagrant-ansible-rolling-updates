#!/bin/bash

source ./environment

echo "Make Packer build"
sleep 2
packer --force build ${PACKER_OS}

echo "execute Vagrant up process"
sleep 2
vagrant up