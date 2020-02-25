
variable "app_name" {
  description = "Name of application"
}

variable "environement" {
  description = "Environement Name"
}


resource "azurerm_resource_group" "rg-app" {
  name     = upper(format("RG-%s-%s",var.app-name,var.environement))
  location = "westeurope"
}

#FOR CONDITION
#resource "azurerm_resource_group" "rg-app" {
#  name     = var.environement == "Production" ? upper(format("RG-%s",var.app-name)) : upper(format("RG-%s-%s",var.app-name,var.environement))
#  location = "westeurope"
#}