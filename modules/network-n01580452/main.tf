resource "azurerm_virtual_network" "n01580452-VNET" {
    name = var.VNET-n01580452-info.name
    resource_group_name = var.VNET-n01580452-info.resource_group_name
    location = var.VNET-n01580452-info.location
    address_space = var.VNET-n01580452-address_space
    tags = var.tags
}

resource "azurerm_subnet" "n01580452-SUBNET" {
    name = var.SUBNET-n01580452-info.name
    resource_group_name = var.VNET-n01580452-info.resource_group_name
    virtual_network_name = azurerm_virtual_network.n01580452-VNET.name
    address_prefixes = var.SUBNET-n01580452-address_prefixes
}

resource "azurerm_network_security_group" "n01580452-NET-SG" {
    name = "network-sg"
    resource_group_name = var.VNET-n01580452-info.resource_group_name
    location = var.VNET-n01580452-info.location

    security_rule {
        name = "rule-1"
        direction = "Inbound"
        access = "Allow"
        priority = 100
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name = "rule-2"
        direction = "Inbound"
        access = "Allow"
        priority = 101
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "3389"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name = "rule-3"
        direction = "Inbound"
        access = "Allow"
        priority = 102
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "5985"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name = "rule-4"
        direction = "Inbound"
        access = "Allow"
        priority = 103
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }
    tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "name" {
    subnet_id = azurerm_subnet.n01580452-SUBNET.id
    network_security_group_id = azurerm_network_security_group.n01580452-NET-SG.id
}