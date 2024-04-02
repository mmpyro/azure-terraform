resource "azurerm_network_interface" "nic_vm1" {
  name                = "${local.vm1}-nic"
  location            = azurerm_resource_group.vm1.location
  resource_group_name = azurerm_resource_group.vm1.name

  ip_configuration {
    name                          = local.vm1
    subnet_id                     = azurerm_subnet.subnet_vm1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm1.id
  }
}

resource "azurerm_virtual_machine" "vm1" {
  name                  = local.vm1
  location              = azurerm_resource_group.vm1.location
  resource_group_name   = azurerm_resource_group.vm1.name
  network_interface_ids = [azurerm_network_interface.nic_vm1.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "osdisk-${local.vm1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = local.vm1
    admin_username = local.username
    admin_password = local.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "nic_vm2" {
  name                 = "${local.vm2}-nic"
  location             = azurerm_resource_group.vm2.location
  resource_group_name  = azurerm_resource_group.vm2.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = local.vm2
    subnet_id                     = azurerm_subnet.subnet_vm2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm2.id
  }
}

resource "azurerm_virtual_machine" "vm2" {
  name                  = local.vm2
  location              = azurerm_resource_group.vm2.location
  resource_group_name   = azurerm_resource_group.vm2.name
  network_interface_ids = [azurerm_network_interface.nic_vm2.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "osdisk-${local.vm2}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = local.vm2
    admin_username = local.username
    admin_password = local.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  connection {
    type     = "ssh"
    user     = local.username
    password = local.password
    host     = azurerm_public_ip.vm2.ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf"
    ]
  }
}

resource "azurerm_network_interface" "nic_vm3" {
  name                = "${local.vm3}-nic"
  location            = azurerm_resource_group.vm3.location
  resource_group_name = azurerm_resource_group.vm3.name

  ip_configuration {
    name                          = local.vm3
    subnet_id                     = azurerm_subnet.subnet_vm3.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm3" {
  name                  = local.vm3
  location              = azurerm_resource_group.vm3.location
  resource_group_name   = azurerm_resource_group.vm3.name
  network_interface_ids = [azurerm_network_interface.nic_vm3.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "osdisk-${local.vm3}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = local.vm3
    admin_username = local.username
    admin_password = local.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}