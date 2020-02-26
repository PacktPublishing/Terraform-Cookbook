
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
   version = "< 2.0.0"
}

locals {
  common_app_settings = {
    "INSTRUMENTATIONKEY" = azurerm_application_insights.appinsight-app.instrumentation_key
  }
}

resource "azurerm_resource_group" "rg-app" {
  name     = "${var.resource_groupe_name}-${var.environement}"
  location = var.location
  tags = {
    ENV = var.environement
  }
}


data "azurerm_app_service_plan" "myplan" {
  name                = "app-service-plan"
  resource_group_name = "rg-service_plan"
}

resource "azurerm_app_service" "app" {
  name                = "${var.app_name}-${var.environement}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  app_service_plan_id = data.azurerm_app_service_plan.myplan.id
}

resource "azurerm_application_insights" "appinsight-app" {
  name                = "${var.app_name}-${var.environement}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  application_type    = "Web"

  tags = {
    ENV = var.environement
    CreatedBy = var.createdby
  }
}
