resource "azurerm_network_interface" "nic_dev" {
  name                = "${local.dev}-nic"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  ip_configuration {
    name                          = local.dev
    subnet_id                     = azurerm_subnet.subnet_dev1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "dev" {
  name                  = local.dev
  location              = azurerm_resource_group.dev.location
  resource_group_name   = azurerm_resource_group.dev.name
  network_interface_ids = [azurerm_network_interface.nic_dev.id]
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
    name              = "osdisk-${local.dev}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = local.dev
    admin_username = local.username
    admin_password = local.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "nic_prod" {
  name                = "${local.prod}-nic"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name

  ip_configuration {
    name                          = local.prod
    subnet_id                     = azurerm_subnet.subnet_prod1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "prod" {
  name                  = local.prod
  location              = azurerm_resource_group.prod.location
  resource_group_name   = azurerm_resource_group.prod.name
  network_interface_ids = [azurerm_network_interface.nic_prod.id]
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
    name              = "osdisk-${local.prod}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = local.prod
    admin_username = local.username
    admin_password = local.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "nic_prod2" {
  name                = "${local.prod}-2-nic"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name

  ip_configuration {
    name                          = "${local.prod}-2"
    subnet_id                     = azurerm_subnet.subnet_prod2_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "prod2" {
  name                  = "${local.prod}-2"
  location              = azurerm_resource_group.prod.location
  resource_group_name   = azurerm_resource_group.prod.name
  network_interface_ids = [azurerm_network_interface.nic_prod2.id]
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
    name              = "osdisk-${local.prod}-2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = local.prod
    admin_username = local.username
    admin_password = local.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}