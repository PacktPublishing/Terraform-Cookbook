
provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = "westeurope"
  resource_group_name = var.resource_group_name

  tags = {
    environment = "Terraform Demo"
  }
}


resource "azurerm_subnet" "subnet" {
  name                 = var.vnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}