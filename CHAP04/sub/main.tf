terraform { required_version = ">= 0.12" }
provider "azurerm" {}

variable "rg_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "location"
  default     = "westeurope"
}

resource "azurerm_resource_group" "rg-app" {
  name     = var.rg_name
  location = var.location
  tags = {
  ENV = "DEMO" }
}
