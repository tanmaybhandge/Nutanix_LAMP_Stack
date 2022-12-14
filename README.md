# Nutanix LAMP Stack VMs Deployment


This repository deploys Virtual Machine's and configures the Web & DB packages in deployed VMs on Nutanix cluster using Infrastructure as code with Terraform.

Pre-requites

- Terraform
- Adding nutanix as a required provider.
- Create two VMs in Nutanix, clone it and modify the VM Disk as image template. We require OS image on Nutanix cluster. We require 2 VMs (Ubuntu & CentOS). I have used Ubuntu as web server and CentOS for Database server. You may use different OS image, but you may need to modify the script as per OS. Refer scripts - https://github.com/tanmaybhandge/Wordpress_scripts
- Make sure networking VLAN has been configured.
- Establish the connectivity to Prism.
- Make sure there is network communication between DataBase VM and Web Server VM.


Web Server Image Requirments
- I have already created the image of Ubuntu 22.04 LTS.
- Sudo access for the user, this is for remote access through provisioner.
- Internet connectivity to download the script from git. You may store the script in the locally and make the changes on provisioner.


Database Server Requirments
- I have already build the centos 7 image in prism.
- With the help of remote execution provisioner, we are installing maridb with random password.
- Due to security reason, storing the password on /root in INIT_PASSWORD file.

### Configuration

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
```
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

4. You may configure the username & password of the VM mentioned on the main.tf to remotely execute the script.
```hcl
## Under vm1 block ##

  connection {
    type     = "ssh"
    user     = "root"
    password = "<password goes here>"
    host     = nutanix_virtual_machine.vm1.nic_list_status[0].ip_endpoint_list[0].ip
  }

## Under vm2 block ##
 connection {
    type     = "ssh"
    user     = "root"
    password = "<password goes here>"
    host     = nutanix_virtual_machine.vm2.nic_list_status[0].ip_endpoint_list[0].ip
  }
```

5. After the resources deployment, you will find the output of VMs name and IP Addresses on the terminal. Login to the Database VM and naivate to ```/root``` path, you will find the ```INIT_PASSWORD``` file, open it and note down the password.

6. Open the web browser from client system, type http://<IP address of the web server>/wordpress. You will get the first screen of the WordPress installer. Select your language for the WordPress and click on Continue.

7. Next, enter the information about the MySQL database.
    Dataabse name - wordpress
    username - myuser
    Password - <Enter the password captured on step 5>
    Database Host - <Paste the IP address of Database VM>
  
### Providers

| Name | Version |
|------|---------|
nutanix | >= 1.7.0
terraform | >= 1.2.7

### Architecture

<img src="https://github.com/tanmaybhandge/Nutanix_LAMP_Stack/blob/main/DB%20%26%20Application.jpeg" width="500" height="400">

### Running this repository
Initialize the modules (and download the Nutanix Provider) by running terraform init.

    $ terraform init

Once you???ve initialized the directory, it???s good to run the validate command before you run ```plan``` or ```apply```. Validation will catch syntax errors, version errors, and other issues.
    
    $ terraform validate

Next, it???s always a good idea to do a dry run of your plan to see what it???s actually going to do. You can even use one of the subcommands with terraform plan to output your plan to apply it later.

    $ terraform plan

You can execute ```apply``` command, this command will deploy or applies your configuration.

    $ terraform apply

If you would like to remove / delete the resources which has been launched, you can execute the destroy command. This command will destroy your Infrastructure.

    $ terraform destroy
   

