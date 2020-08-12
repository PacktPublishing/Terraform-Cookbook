terraform { required_version = ">= 0.12" }
provider "azurerm" {
  features {}
}

variable "rg_name" {
  description = "Name of the resource group"
  default ="RG-DEMO-APP"
}

variable "location" {
  description = "location"
  default     = "westeurope"
}

resource "azurerm_resource_group" "rg-app" {
  name     = var.rg_name
  location = var.location
  tags = {
    ENV = var.environment 
  }
}

variable "environment" {
  default = "DEMO"
}
