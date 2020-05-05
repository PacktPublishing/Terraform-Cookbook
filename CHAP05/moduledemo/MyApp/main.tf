
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-app" {
  name     = "RG_MyAPP"
  location = "West Europe"
}


module "webapp" {
  source = "..\/Moduless\/webapp"
  service_plan_name = "spmyapp"
  app_name = "myapp"
  location = azurerm_resource_group.rg-app.location
  resource_groupe_name = azurerm_resource_group.rg-app.name
}

output "webapp_url" {
  value = module.webapp.webapp_url
}