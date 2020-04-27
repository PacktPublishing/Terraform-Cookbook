terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
    version = "< 2.0.0"
}

variable "resource_group_name" {
  default = "rg_test"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "West Europe"
}

resource "azurerm_public_ip" "pip" {
  name                         = "book-ip"
  location                     = "West Europe"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "Dynamic"
  domain_name_label            = "bookdevops"
}
