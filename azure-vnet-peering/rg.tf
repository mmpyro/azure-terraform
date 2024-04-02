resource "azurerm_resource_group" "vm1" {
  name     = local.vm1
  location = "East US"
}

resource "azurerm_resource_group" "vm2" {
  name     = local.vm2
  location = "North Europe"
}

resource "azurerm_resource_group" "vm3" {
  name     = local.vm3
  location = "North Europe"
}