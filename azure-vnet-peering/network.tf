resource "azurerm_virtual_network" "vnet_vm1" {
  name                = "${local.vm1}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vm1.location
  resource_group_name = azurerm_resource_group.vm1.name
}

resource "azurerm_subnet" "subnet_vm1" {
  name                 = local.vm1
  resource_group_name  = azurerm_resource_group.vm1.name
  virtual_network_name = azurerm_virtual_network.vnet_vm1.name
  address_prefixes     = [local.vm1_subnet_address]
}

resource "azurerm_virtual_network" "vnet_vm2" {
  name                = "${local.vm2}-network"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.vm2.location
  resource_group_name = azurerm_resource_group.vm2.name
}

resource "azurerm_subnet" "subnet_vm2" {
  name                 = local.vm2
  resource_group_name  = azurerm_resource_group.vm2.name
  virtual_network_name = azurerm_virtual_network.vnet_vm2.name
  address_prefixes     = ["10.1.0.0/18"]
}

resource "azurerm_virtual_network" "vnet_vm3" {
  name                = "${local.vm3}-network"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.vm3.location
  resource_group_name = azurerm_resource_group.vm3.name
}

resource "azurerm_subnet" "subnet_vm3" {
  name                 = local.vm3
  resource_group_name  = azurerm_resource_group.vm3.name
  virtual_network_name = azurerm_virtual_network.vnet_vm3.name
  address_prefixes     = [local.vm3_subnet_address]
}

# PEERING

resource "azurerm_virtual_network_peering" "vnet1-to-vnet2" {
  name                         = "${local.vm1}-to-${local.vm2}"
  resource_group_name          = azurerm_resource_group.vm1.name
  virtual_network_name         = azurerm_virtual_network.vnet_vm1.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_vm2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "vnet2-to-vnet1" {
  name                         = "${local.vm2}-to-${local.vm1}"
  resource_group_name          = azurerm_resource_group.vm2.name
  virtual_network_name         = azurerm_virtual_network.vnet_vm2.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_vm1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "vnet2-to-vnet3" {
  name                         = "${local.vm2}-to-${local.vm3}"
  resource_group_name          = azurerm_resource_group.vm2.name
  virtual_network_name         = azurerm_virtual_network.vnet_vm2.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_vm3.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "vnet3-to-vnet2" {
  name                         = "${local.vm3}-to-${local.vm2}"
  resource_group_name          = azurerm_resource_group.vm3.name
  virtual_network_name         = azurerm_virtual_network.vnet_vm3.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_vm2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
