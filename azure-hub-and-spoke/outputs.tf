output "dev_vm_ip" {
  value = azurerm_network_interface.nic_dev.private_ip_address
}

output "prod_vm_ip" {
  value = azurerm_network_interface.nic_prod.private_ip_address
}

output "prod2_vm_ip" {
  value = azurerm_network_interface.nic_prod2.private_ip_address
}
