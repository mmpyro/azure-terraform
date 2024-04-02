resource "azurerm_network_ddos_protection_plan" "hub_ddos_protection_plan" {
  location            = "eastus"
  name                = "hub-ddos"
  resource_group_name = azurerm_resource_group.hub.name
}