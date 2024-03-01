
# Terragrunt & Ansible
 Hi
![Image Alt Text](/design/terragrunt_ansible.png)

### What does it do?

Creates infra using [Terragrunt](https://terragrunt.gruntwork.io/) a tool to keep Terraform DRY and at the same time also deploys ansible on two GCP projects. One project being a management project (master node) and the other as a dev project (dev node - serves web page).Terragrunt
essentially helps to keep TF state in one location. 

### Features 

- Dev container (Terragrunt ready)
- Terragrunt common.hcl file to manage state in cenrtal location
- Ansible installed on master node and serves playbooks to dev vm
- GCP infra (Compute,VPC,Cloud Nat,Cloud Router,Firewall,VPC Peering and GCS)
- Networking designed to limit access and only allow ssh in the GCP 
  console via Identity Aware Proxy (IAP)  

Ensure you have access to the projects in GCP you want to deploy this on.

```sh
gcloud auth application-default login / if required -no-launch-browser
gcloud config set project {your_project_gcp}
```

In each project deploy the infra in the network folders starting with mgmt then followed by dev. Then
move onto deploying the vm's.

```sh
Terragrunt init
Terragrunt plan
Terragrunt apply / if required -lock=false
```

Once deployed via terragrunt you should be able to ssh onto the master node vm in order 
to complete the [Ansible](https://docs.ansible.com/) installation.

*Please note that the startup script on the master node vm might take a couple of minutes to complete!*

*Then replace dev-vm IP, ansible_user under ansible/hosts & create newusername with preferrably the name ansible on the master node.*

```sh
sudo nano /etc/ansible/hosts

control_machine ansible_connection=local ansible_user=(enter_your_user) - update with user you will be creating

[servers]
dev-vm ansible_host=0.0.0.0 - update the ip to reflect dev vm

sudo adduser newusername
sudo usermod -aG sudo newusername
su - newusername
ssh-keygen -t rsa -b 4096 -C "user_email@ansible.com"
cat the ssh pub key 
```
Copy the public key and place it in the project where the dev 
vm is under in this location on gcp https://console.cloud.google.com/compute/metadata/sshKeys, so that the master node vm can access the dev vm.

Head back to the master node vm and lets install Nginx plus test the connection.
```sh
ansible all -m ping -u - should show a successful connection
ssh newusername@ip_address_dev_vm - if you can ssh (type exit to return back to master vm)
sudo mkdir playbook
cd playbook
sudo nano touch index.html

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello Dev</title>
</head>
<body>
    <h1>Hello, {{ ansible_hostname }}!</h1>
</body>
</html>

sudo nano touch nginx.yml

---
- name: Nginx
  hosts: dev-vm
  become: yes
  remote_user: mammenarjun2
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Create HTML file
      template:
        src: index.html
        dest: /var/www/html/index.html

```
Now you have a playbook that is ready to run with ansible's push method. 
Simply run the below command with your created user in the master node vm to
push the playbook config to your dev vm.

```sh
ansible-playbook -u yourusername --ask-become-pass  nginx.yml
```

Once that is completed head over to the dev project and find the 
external IP of the dev vm to test the ansible created web page!
