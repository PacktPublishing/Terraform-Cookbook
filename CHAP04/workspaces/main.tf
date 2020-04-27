terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg-app" {
  name     = "RG-APP-${terraform.workspace}"
  location = "westeurope"
}