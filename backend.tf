terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01580452RG"
    storage_account_name = "tfstaten01580452sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}
