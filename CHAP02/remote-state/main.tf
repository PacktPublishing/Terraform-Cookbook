
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  skip_provider_registration = true
}

locals {
  common_app_settings = {
    "INSTRUMENTATIONKEY" = azurerm_application_insights.appinsight-app.instrumentation_key
  }
}

resource "azurerm_resource_group" "rg-app" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location
  tags = {
    ENV = var.environment
  }
}


data "terraform_remote_state" "service_plan_tfstate" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg_tfstate"
    storage_account_name = "storstate"
    container_name       = "tfbackends"
    key                  = "serviceplan.tfstate"
  }
}

resource "azurerm_app_service" "app" {
  name                = "${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  app_service_plan_id = data.terraform_remote_state.service_plan_tfstate.service_plan_id
}

resource "azurerm_application_insights" "appinsight-app" {
  name                = "${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  application_type    = "Web"

  tags = {
    ENV       = var.environment
    CreatedBy = var.createdby
  }
}
