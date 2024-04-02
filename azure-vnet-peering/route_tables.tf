resource "azurerm_route_table" "route_vm1" {
  name                          = "${local.vm1}-route"
  location                      = azurerm_resource_group.vm1.location
  resource_group_name           = azurerm_resource_group.vm1.name
  disable_bgp_route_propagation = false

  route {
    name                   = "${local.vm3}-route"
    address_prefix         = local.vm3_subnet_address
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_network_interface.nic_vm2.private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "route_vm1_association" {
  subnet_id      = azurerm_subnet.subnet_vm1.id
  route_table_id = azurerm_route_table.route_vm1.id
}

resource "azurerm_route_table" "route_vm3" {
  name                          = "${local.vm3}-route"
  location                      = azurerm_resource_group.vm3.location
  resource_group_name           = azurerm_resource_group.vm3.name
  disable_bgp_route_propagation = false

  route {
    name                   = "${local.vm1}-route"
    address_prefix         = local.vm1_subnet_address
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_network_interface.nic_vm2.private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "route_vm3_association" {
  subnet_id      = azurerm_subnet.subnet_vm3.id
  route_table_id = azurerm_route_table.route_vm3.id
}