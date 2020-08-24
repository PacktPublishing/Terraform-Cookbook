
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

locals {
  common_app_settings = {
    "INSTRUMENTATIONKEY" = azurerm_application_insights.appinsight-app.instrumentation_key
  }
}

resource "azurerm_resource_group" "rg-app" {
  name     = "${var.resource_group_name}-${var.environement}"
  location = var.location
  tags = {
    ENV = var.environement
  }
}

resource "azurerm_app_service_plan" "plan-app" {
  name                = "${var.service_plan_name}-${var.environement}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    ENV       = var.environement
    CreatedBy = var.createdby
  }
}

resource "azurerm_app_service" "app" {
  name                = "${var.app_name}-${var.environement}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  app_service_plan_id = azurerm_app_service_plan.plan-app.id
}

resource "azurerm_application_insights" "appinsight-app" {
  name                = "${var.app_name}-${var.environement}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  application_type    = "web"

  tags = {
    ENV       = var.environement
    CreatedBy = var.createdby
  }
}

output "webapp_hostname" {
  description = "hostname of the webapp"
  value       = azurerm_app_service.app.default_site_hostname
}

output "webapp_name" {
  description = "output Name of the webapp"
  value       = azurerm_app_service.app.name
}