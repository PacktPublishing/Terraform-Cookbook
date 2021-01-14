
provider "azurerm" {
  features {}
}

variable "app_name" {
  description = "Name of application"
}

variable "environment" {
  description = "Environment Name"
}


#resource "azurerm_resource_group" "rg-app" {
#  name     = upper(format("RG-%s-%s",var.app_name,var.environment))
#  location = "westeurope"
#}

#FOR CONDITION
resource "azurerm_resource_group" "rg-app" {
  name     = var.environment == "Production" ? upper(format("RG-%s", var.app_name)) : upper(format("RG-%s-%s", var.app_name, var.environment))
  location = "westeurope"
}
