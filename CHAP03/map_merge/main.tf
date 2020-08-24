
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-app" {
  name     = "${var.resource_group_name}-${var.environement}"
  location = var.location
  ## OLD CODE WIThOUT MAP
  #tags = {
  #  ENV = var.environement
  #  CREATEDBY = var.created_by
  #}

  tags = var.tags
}

resource "azurerm_app_service_plan" "plan-app" {
  name                = "${var.service_plan_name}-${var.environement}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

locals {
  default_app_settings = {
    "DEFAULT_KEY1" = "DEFAULT_VAL1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "${var.app_name}-${var.environement}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  app_service_plan_id = azurerm_app_service_plan.plan-app.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = merge(local.default_app_settings,var.custom_app_settings)

  #app_settings = {"KEY1" = "VAL1", "KEY2" = "VAL2"}

}
