resource "azurerm_network_manager" "network_manager" {
  location            = "eastus"
  name                = "network-manager"
  resource_group_name = azurerm_resource_group.hub.name
  scope_accesses      = ["Connectivity"]
  tags                = {}
  scope {
    management_group_ids = []
    subscription_ids     = [data.azurerm_subscription.current.id]
  }
}

resource "azurerm_network_manager_network_group" "dev" {
  name               = local.dev
  network_manager_id = azurerm_network_manager.network_manager.id
}

resource "azurerm_network_manager_network_group" "prod" {
  name               = local.prod
  network_manager_id = azurerm_network_manager.network_manager.id
}

resource "azurerm_network_manager_connectivity_configuration" "prod" {
  connectivity_topology           = "HubAndSpoke"
  delete_existing_peering_enabled = false
  description                     = null
  global_mesh_enabled             = false
  name                            = "hub-to-prod"
  network_manager_id              = azurerm_network_manager.network_manager.id
  applies_to_group {
    global_mesh_enabled = true
    group_connectivity  = "DirectlyConnected"
    network_group_id    = azurerm_network_manager_network_group.prod.id
    use_hub_gateway     = false
  }
  hub {
    resource_id   = azurerm_virtual_network.vnet_hub.id
    resource_type = "Microsoft.Network/virtualNetworks"
  }
}

resource "azurerm_network_manager_connectivity_configuration" "dev" {
  connectivity_topology           = "HubAndSpoke"
  delete_existing_peering_enabled = false
  description                     = null
  global_mesh_enabled             = false
  name                            = "hub-to-dev"
  network_manager_id              = azurerm_network_manager.network_manager.id
  applies_to_group {
    global_mesh_enabled = true
    group_connectivity  = "DirectlyConnected"
    network_group_id    = azurerm_network_manager_network_group.dev.id
    use_hub_gateway     = false
  }
  hub {
    resource_id   = azurerm_virtual_network.vnet_hub.id
    resource_type = "Microsoft.Network/virtualNetworks"
  }
}

resource "azurerm_network_manager_deployment" "eastus_deployment" {
  network_manager_id = azurerm_network_manager.network_manager.id
  location           = "eastus"
  scope_access       = "Connectivity"
  configuration_ids  = [azurerm_network_manager_connectivity_configuration.dev.id, azurerm_network_manager_connectivity_configuration.prod.id]
}

resource "azurerm_network_manager_deployment" "northeurope_deployment" {
  network_manager_id = azurerm_network_manager.network_manager.id
  location           = "northeurope"
  scope_access       = "Connectivity"
  configuration_ids  = [azurerm_network_manager_connectivity_configuration.dev.id, azurerm_network_manager_connectivity_configuration.prod.id]
}

resource "azurerm_network_manager_static_member" "dev" {
  name                      = "dev-network"
  network_group_id          = azurerm_network_manager_network_group.dev.id
  target_virtual_network_id = azurerm_virtual_network.vnet_dev.id
}

resource "azurerm_network_manager_static_member" "prod" {
  name                      = "prod-network"
  network_group_id          = azurerm_network_manager_network_group.prod.id
  target_virtual_network_id = azurerm_virtual_network.vnet_prod.id
}

resource "azurerm_network_manager_static_member" "prod2" {
  name                      = "prod-2-network"
  network_group_id          = azurerm_network_manager_network_group.prod.id
  target_virtual_network_id = azurerm_virtual_network.vnet_prod2.id
}