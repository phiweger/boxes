#! bin/bash

sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install -y ansible

# provision
ansible-playbook /shared/playbook.yml

# selective provision using ansible tags
# ansible-playbook /shared/playbook.yml --tags 'new'

# install python packages
# pip or pip3, modify accordingly
pip3 install --upgrade pip
pip3 install --user -r /shared/requirements.txt
# Don't "sudo pip", use "--user" instead: stackoverflow, 27870003, 33004708