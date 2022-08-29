resource "nutanix_virtual_machine" "vm1" {
  name                 = var.vm_name_webserver
  cluster_uuid         = data.nutanix_cluster.myCluster.id
  num_vcpus_per_socket = var.vcpus_per_socket
  num_sockets          = var.no_socket
  memory_size_mib      = var.Memory_in_MB

  # Now we are using built in funcationility of the terraform to install the web server
  connection {
    type     = "ssh"
    user     = "nutanix"
    password = "<OS password goes here>"
    host     = nutanix_virtual_machine.vm1.nic_list_status[0].ip_endpoint_list[0].ip
  }

  provisioner "remote-exec" {
    inline = [

      "curl https://raw.githubusercontent.com/tanmaybhandge/Wordpress_scripts/main/web -o wp.sh",
      "sudo sh wp.sh",

    ]
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet_info.id
  }

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.image_info_webserver.id
    }

    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }
    }
  }

}

############################ DB Server ########################################

resource "nutanix_virtual_machine" "vm2" {
  name                 = var.vm_name_dbserver
  cluster_uuid         = data.nutanix_cluster.myCluster.id
  num_vcpus_per_socket = var.vcpus_per_socket
  num_sockets          = var.no_socket
  memory_size_mib      = var.Memory_in_MB

  # Now we are using built in funcationility of the terraform to install the web server
  connection {
    type     = "ssh"
    user     = "root"
    password = "<OS password goes here>"
    host     = nutanix_virtual_machine.vm2.nic_list_status[0].ip_endpoint_list[0].ip
  }

  provisioner "remote-exec" {
    inline = [

      "#To aviod the protocol error",
      "yum update -y nss curl libcurl",

      "curl https://raw.githubusercontent.com/tanmaybhandge/Wordpress_scripts/main/db.sh -o db.sh",
      "sudo sh db.sh",
    ]
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet_info.id
  }

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.image_info_dbserver.id
    }

    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }
    }
  }

}
