# Nutanix LAMP Stack VM Deployment


This repository deploys Virtual Machine's and configures the web & DB packages in deployed VM on Nutanix cluster using Infrastructure as code with Terraform.

Pre-requites

- Terraform
- Adding nutanix as a required provider.
- Create the new VM in Nutanix, clone it and modify the VM Disk as image template. We require OS image on Nutanix cluster.
- We require 2 VMs (Ubuntu & CentOS). I have used Ubuntu as web server and CentOS for Database server. You may use different OS image, but you may need to modify the script as per OS. Refer scripts - https://github.com/tanmaybhandge/Wordpress_scripts
- Make sure networking VLAN has been configured.
- Establish the connectivity to Prism.
- Make sure there is network communication between DataBase VM and Web Server VM.
