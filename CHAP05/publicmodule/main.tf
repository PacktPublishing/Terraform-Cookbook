
terraform { required_version = ">= 0.12" }
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "my-rg"
  location = "West Europe"
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = "vnetdemo"
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnetdemo"]
}