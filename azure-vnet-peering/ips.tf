resource "azurerm_public_ip" "vm1" {
  name                = "${local.vm1}-ip"
  location            = azurerm_resource_group.vm1.location
  resource_group_name = azurerm_resource_group.vm1.name
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "vm2" {
  name                = "${local.vm2}-ip"
  location            = azurerm_resource_group.vm2.location
  resource_group_name = azurerm_resource_group.vm2.name
  allocation_method   = "Static"
}