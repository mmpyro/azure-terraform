resource "azurerm_network_security_group" "nsg_vm1" {
  name                = "nsg-${local.vm1}"
  location            = azurerm_resource_group.vm1.location
  resource_group_name = azurerm_resource_group.vm1.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_vm1" {
  subnet_id                 = azurerm_subnet.subnet_vm1.id
  network_security_group_id = azurerm_network_security_group.nsg_vm1.id
}

resource "azurerm_network_security_group" "nsg_vm2" {
  name                = "nsg-${local.vm2}"
  location            = azurerm_resource_group.vm2.location
  resource_group_name = azurerm_resource_group.vm2.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "icmp-1"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.0/18"
    destination_address_prefix = "10.1.0.4/32"
  }

  security_rule {
    name                       = "icmp-2"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.0/18"
    destination_address_prefix = "10.2.0.4/32"
  }

  security_rule {
    name                       = "deny-internal"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_vm2" {
  subnet_id                 = azurerm_subnet.subnet_vm2.id
  network_security_group_id = azurerm_network_security_group.nsg_vm2.id
}

resource "azurerm_network_security_group" "nsg_vm3" {
  name                = "nsg-${local.vm3}"
  location            = azurerm_resource_group.vm3.location
  resource_group_name = azurerm_resource_group.vm3.name

  security_rule {
    name                       = "icmp-1"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.0/18"
    destination_address_prefix = "10.2.0.4/32"
  }

  security_rule {
    name                       = "icmp-2"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.1.0.0/18"
    destination_address_prefix = "10.2.0.4/32"
  }

  security_rule {
    name                       = "deny-internal"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_vm3" {
  subnet_id                 = azurerm_subnet.subnet_vm3.id
  network_security_group_id = azurerm_network_security_group.nsg_vm3.id
}