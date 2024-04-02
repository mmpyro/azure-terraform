resource "azurerm_virtual_network" "vnet_hub" {
  name                = "hub-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  ddos_protection_plan {
    enable = false
    id     = azurerm_network_ddos_protection_plan.hub_ddos_protection_plan.id
  }
}

resource "azurerm_subnet" "subnet_hub" {
  name                 = "hub"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["10.0.0.0/18"]
}

resource "azurerm_subnet" "subnet_bastion" {
  name                                           = "AzureBastionSubnet"
  resource_group_name                            = azurerm_resource_group.hub.name
  virtual_network_name                           = azurerm_virtual_network.vnet_hub.name
  address_prefixes                               = ["10.0.64.0/26"]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "subnet_firewall_management" {
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["10.0.64.64/26"]
}

resource "azurerm_subnet" "subnet_firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["10.0.64.128/26"]
}

resource "azurerm_virtual_network" "vnet_dev" {
  name                = "${local.dev}-network"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
}

resource "azurerm_subnet" "subnet_dev1" {
  name                 = local.dev
  resource_group_name  = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.vnet_dev.name
  address_prefixes     = ["10.1.0.0/18"]
}

resource "azurerm_virtual_network" "vnet_prod" {
  name                = "${local.prod}-network"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
}

resource "azurerm_subnet" "subnet_prod1" {
  name                 = local.prod
  resource_group_name  = azurerm_resource_group.prod.name
  virtual_network_name = azurerm_virtual_network.vnet_prod.name
  address_prefixes     = ["10.2.0.0/18"]
}

resource "azurerm_virtual_network" "vnet_prod2" {
  name                = "${local.prod}-2-network"
  address_space       = ["10.3.0.0/16"]
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
}

resource "azurerm_subnet" "subnet_prod2_1" {
  name                 = "${local.prod}-2"
  resource_group_name  = azurerm_resource_group.prod.name
  virtual_network_name = azurerm_virtual_network.vnet_prod2.name
  address_prefixes     = ["10.3.0.0/18"]
}