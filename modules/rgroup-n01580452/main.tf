resource "azurerm_resource_group" "n01580452-RG" {
    name = var.rg-n01580452-info.name
    location = var.rg-n01580452-info.location
    tags = var.tags
}