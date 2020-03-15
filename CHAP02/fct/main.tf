
provider "azurerm" {
  version = "< 2.0.0"
}

variable "app_name" {
  description = "Name of application"
}

variable "environement" {
  description = "Environement Name"
}


#resource "azurerm_resource_group" "rg-app" {
#  name     = upper(format("RG-%s-%s",var.app_name,var.environement))
#  location = "westeurope"
#}

#FOR CONDITION
resource "azurerm_resource_group" "rg-app" {
  name     = var.environement == "Production" ? upper(format("RG-%s", var.app_name)) : upper(format("RG-%s-%s", var.app_name, var.environement))
  location = "westeurope"
}
