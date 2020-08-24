
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-app" {
  name     = "RG_MyAPP_Demo"
  location = "West Europe"
}

module "webapp" {
  source               = "../Modules/webapp"
  service_plan_name    = "spmyapp"
  app_name             = "myappdemobook"
  location             = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
}

output "webapp_url" {
  value = module.webapp.webapp_url
}