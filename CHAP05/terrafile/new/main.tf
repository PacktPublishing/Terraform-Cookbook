terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

module "resourcegroup" {
  source              = "./modules/rg-master"
  resource_group_name = "RG_MyAPP_Demo2"
  location            = "West Europe"
}

module "webapp" {
  source               = "./modules/webapp-1.0.0"
  service_plan_name    = "spmyapp2"
  app_name             = "myappdemobook2"
  location             = "West Europe"
  resource_groupe_name = module.resourcegroup.resource_group_name
}


module "network" {
  source              = "./modules/network-3.0.1"
  resource_group_name = module.resourcegroup.resource_group_name
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]
}
