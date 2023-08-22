output "n01580452-VNET-name" {
    value = azurerm_virtual_network.n01580452-VNET.name
}

output "n01580452-SUBNET" {
    value = {
        id = azurerm_subnet.n01580452-SUBNET.id
        name = azurerm_subnet.n01580452-SUBNET.name
    }
}