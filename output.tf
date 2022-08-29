output "ip_address_vm1" {
  value = nutanix_virtual_machine.vm1.nic_list_status[0].ip_endpoint_list[0].ip
}

output "VM1_name" {
  value = nutanix_virtual_machine.vm1.name
}


output "VM2_name" {
  value = nutanix_virtual_machine.vm2.name
}

output "ip_address_vm2" {
  value = nutanix_virtual_machine.vm2.nic_list_status[0].ip_endpoint_list[0].ip
}

