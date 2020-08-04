provider "azurerm" {}

variable "resource_group_name" {
  default = "rg_test"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "West Europe"
}

resource "azurerm_public_ip" "pip" {
  name                = "book-ip"
  location            = "West Europe"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  allocation_method   = "Dynamic"
  domain_name_label   = "bookdevops"
}