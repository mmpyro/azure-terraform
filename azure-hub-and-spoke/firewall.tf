resource "azurerm_public_ip" "firewall_ip" {
  name                = "hub-firewall-ip"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = local.zones
}

resource "azurerm_public_ip" "firewall_management_ip" {
  name                = "hub-firewall-management-ip"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = local.zones
}
