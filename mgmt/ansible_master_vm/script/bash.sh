#!/bin/bash

sudo apt update -y &&
sudo add-apt-repository --yes --update ppa:ansible/ansible &&
sudo DEBIAN_FRONTEND=noninteractive apt update -y &&
sudo DEBIAN_FRONTEND=noninteractive apt install -y ansible

hosts_content="[master]
control_machine ansible_connection=local ansible_user=(enter_your_user)

[servers]
dev-vm ansible_host=0.0.0.0
  
[all:vars]
ansible_python_interpreter=/usr/bin/python3
"
echo "$hosts_content" | sudo tee /etc/ansible/hosts > /dev/null



