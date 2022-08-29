## Web Server ##

variable "vm_name_webserver" {
  type    = string
  default = "WebServer_TF"
}

variable "image_name_webserver" {
  type    = string
  default = "ubuntu_final"

}

data "nutanix_image" "image_info_webserver" {
  image_name = var.image_name_webserver
}


## Web Server ##

variable "vm_name_dbserver" {
  type    = string
  default = "DBServer_TF"
}

variable "image_name_dbserver" {
  type    = string
  default = "CentOS"

}

data "nutanix_image" "image_info_dbserver" {
  image_name = var.image_name_dbserver
}


## Common ## 


variable "Memory_in_MB" {
  type    = number
  default = 2048
}

variable "vcpus_per_socket" {
  type    = number
  default = 1
}

variable "no_socket" {
  type    = number
  default = 1
}

variable "cluster_name" {
  type    = string
  default = "PHX-POC306"
}

variable "subnet_name" {
  type    = string
  default = "Primary"
}

variable "image_name" {
  type    = string
  default = "CentOS"

}

data "nutanix_cluster" "myCluster" {
  name = var.cluster_name
}

data "nutanix_subnet" "subnet_info" {
  subnet_name = var.subnet_name
}

