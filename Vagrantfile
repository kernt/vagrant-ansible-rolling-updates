# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

# ----- Adding trigger - only after last VM is UP ------ #
# https://stackoverflow.com/questions/25088568/is-it-possible-to-run-a-script-on-a-virtual-machine-after-vagrant-finishes-provi/36330498
# Take the hostname of the last machine in the array
# last_vm = servers[(servers.length) -1][:hostname]
#  node.trigger.after :up do |trigger|
#            trigger.only_on = last_vm  # <---- Just use it here!
#            trigger.info = "Running only after last machine is up!"
#        end
# if i == 2
#   node.vm.provision :shell, inline: 'echo "" > /etc/firstboot'
# end

#  SSH options.
#  config.ssh.insert_key = false
#  config.ssh.forward_agent = true
#  config.ssh.password = "vagrant"
## ---- Trigger ------- ##
#  config.trigger.before :up do |t|
#    t.info = "Bringing up your Vagrant guest machine!"
#  end

  # create some web servers
  # https://docs.vagrantup.com/v2/vagrantfile/tips.html
  # (1..$machine_count).each do |i|

  (1..2).each do |i|
    config.trigger.after :up do |trigger|
      if(i == 2) then
       trigger.info = "Last VM is installed"
       trigger.run_remote = {inline: 'echo "" >> /etc/firstboot'}
      end
    end
    config.vm.define "web#{i}" do |node|
        node.vm.box = "ubuntu/bionic64"
        node.vm.hostname = "web#{i}"
        node.vm.network :private_network, ip: "10.0.15.2#{i}"
        node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
        node.vm.provider "virtualbox" do |vb|
          vb.memory = "512"
        end
        node.vm.provision :shell, path: "netplan-add-dnsserver.sh"
    end

# create load balancer vm
  config.vm.define :lb do |lb_config|
   #config.trigger.after :up do |trigger|
   #   trigger.info = "Create Load Balancer VM"
   #   trigger.ruby do |env,machine|
   #     greetings = "hello there #{machine.id}!"
   #     puts greetings
   #   end
   # end
      lb_config.vm.box = "ubuntu/bionic64"
      lb_config.vm.box_check_update = "true"
      lb_config.vm.hostname = "lb"
      lb_config.vm.network :private_network, ip: "10.0.15.11"
      lb_config.vm.network "forwarded_port", guest: 80, host: 8080
      lb_config.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
      lb_config.vm.provision :shell, path: "netplan-add-dnsserver.sh"
  end

    # create mgmt node
    config.vm.define :mgmt do |mgmt_config|
        mgmt_config.vm.box = "ubuntu/bionic64"
        mgmt_config.vm.box_check_update = "true"
        mgmt_config.vm.hostname = "mgmt"
        mgmt_config.vm.network :private_network, ip: "10.0.15.10"
        mgmt_config.vm.provider "virtualbox" do |vb|
          vb.memory = "1024"
         end
        mgmt_config.vm.provision :shell, path: "bootstrap-mgmt.sh",
          run:"once"
        mgmt_config.trigger.after :up do |trigger|
          trigger.only_on = "web2"
          trigger.run_remote = {path: "./examples/scripts/push-ssh.sh"}
        mgmt_config.vm.provision "ansible_local" do |ansible|
          ansible.playbok.yml
        end
      end
    end
  end
end