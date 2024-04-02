resource "azurerm_resource_group" "hub" {
  name     = "hub"
  location = "East US"
}

resource "azurerm_resource_group" "dev" {
  name     = local.dev
  location = "North Europe"
}

resource "azurerm_resource_group" "prod" {
  name     = local.prod
  location = "North Europe"
}
