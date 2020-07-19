terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

module "resourcegroup" {
  resource_group_name = "RG_MyAPP_DemoTFCLOUD"
  location            = "West Europe"
}

module "webapp" {
  source               = "app.terraform.io/demoBook/webapp/azurerm"
  version              = "1.0.1"
  service_plan_name    = "demoappsp"
  app_name             = "myappdemobookcloud"
  location             = "West Europe"
  resource_groupe_name = module.resourcegroup.resource_group_name
}
