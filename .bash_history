exit
exit
exit
exit
exit
pwd
ls -al
ssh web2
ssh web1
ssh lb
ls
cd examples/
ls
ansible-playbook -i ./inventory.ini
ansible-playbook -i ./inventory.ini ssh-addkey.yml 
ls
vim ssh-addkey.yml 
ansible-playbook -i ./inventory.ini ssh-addkey.yml 
ssh-keygen 
ansible-playbook -i ./inventory.ini ssh-addkey.yml 
ssh web1
man ansible-playbook
ansible-playbook -k -u vagrant -i ./inventory.ini ssh-addkey.yml 
ssh-copy-id lb
ssh-copy-id web1
ssh-copy-id web2
ansible-playbook -b -u vagrant -i ./inventory.ini ssh-addkey.yml
ansible-playbook -u vagrant -i ./inventory.ini ssh-addkey.yml
ssh web1
ansible web1 -m ping
ansible -i ./inventory.ini web1 -m ping
ls
cd ~
ls
cd ~
cd .ssh/
ls
cat id_rsa.pub 
ssh-keyscan web1
cd ..
ssh-keyscan lb web1 web2 >> .ssh/known_hosts
ansible all -m ping --ask-pass
ls
cd examples/
ls
ls al
ls -al
ansible all -i ./inventory.ini -m ping --ask-pass
exit
cd ~
cd .ssh/
ls
vim authorized_keys 
ssh-keyscan web1
exit
