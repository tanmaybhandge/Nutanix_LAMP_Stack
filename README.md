# Nutanix LAMP Stack VMs Deployment


This repository deploys Virtual Machine's and configures the web & DB packages in deployed VM on Nutanix cluster using Infrastructure as code with Terraform.

Pre-requites

- Terraform
- Adding nutanix as a required provider.
- Create the new VM in Nutanix, clone it and modify the VM Disk as image template. We require OS image on Nutanix cluster.
- We require 2 VMs (Ubuntu & CentOS). I have used Ubuntu as web server and CentOS for Database server. You may use different OS image, but you may need to modify the script as per OS. Refer scripts - https://github.com/tanmaybhandge/Wordpress_scripts
- Make sure networking VLAN has been configured.
- Establish the connectivity to Prism.
- Make sure there is network communication between DataBase VM and Web Server VM.


Web Server Image Requirment
- I have already created the image of Ubuntu 22.04 LTS.
- Sudo access for the user, this is for remote access through provisioner.
- Internet connectivity to download the script from git. You may store the script in the locally and make the changes on provisioner.


Database Server Requirment
- I have already build the centos 7 image in prism.
- With the help of remote execution provisioner, we are installing maridb with random password.
- Due to security reason, storing the password on /root in INIT_PASSWORD file.

1. Clone the repository
```git clone https://github.com/tanmaybhandge/Nutanix_LAMP_Stack.git```

2. Update the variables in the  `variables.tf`  file to match your Nutanix environment.
```hcl
## Web Server ##

variable  "vm_name_webserver" {
type  =  string
default  =  "WebServer_TF"
}

variable  "image_name_webserver" {
type  =  string
default  =  "ubuntu_final"
}

data  "nutanix_image"  "image_info_webserver" {
image_name  =  var.image_name_webserver
}

## Database Server ##

variable  "vm_name_dbserver" {
type  =  string
default  =  "DBServer_TF"
}

variable  "image_name_dbserver" {
type  =  string
default  =  "CentOS"
}

data  "nutanix_image"  "image_info_dbserver" {
image_name  =  var.image_name_dbserver
}

## Common ##

variable  "Memory_in_MB" {
type  =  number
default  =  2048
}

variable  "vcpus_per_socket" {
type  =  number
default  =  1
}

variable  "no_socket" {
type  =  number
default  =  1
}

variable  "cluster_name" {
type  =  string
default  =  "PHX-POC306"
}

variable  "subnet_name" {
type  =  string
default  =  "Primary"
}

variable  "image_name" {
type  =  string
default  =  "CentOS"
}

3. You may need to modify the prism configuration on ```provider.tf``` file.

```hcl
provider "nutanix" {
  # Configuration options

  username     = "admin"
  password     = "<password of prism>"
  port         = 9440
  endpoint     = "<IP Address>"
  insecure     = true
  wait_timeout = 10
}
```
