output "n01580452-vmwindows" {
    value = {
        ids = azurerm_windows_virtual_machine.n01580452-vmwindows[*].id
        hostnames = azurerm_windows_virtual_machine.n01580452-vmwindows[*].name
        }
}

output "n01580452-vmwindows-FQDN" {
    value = azurerm_public_ip.n01580452-vmwindows-pip[*].fqdn
}

output "n01580452-vmwindows-private-ip" {
    value = azurerm_windows_virtual_machine.n01580452-vmwindows[*].private_ip_address
}

output "n01580452-vmwindows-public-ip" {
    value = azurerm_windows_virtual_machine.n01580452-vmwindows[*].public_ip_address
}