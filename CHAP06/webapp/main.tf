
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

data "azurerm_storage_account" "storagezip" {
  name                = "storappdemo"
  resource_group_name = "RG-storageApp"
}

data "azurerm_storage_account_sas" "storage_sas" {
  connection_string = data.azurerm_storage_account.storagezip.primary_connection_string
  https_only        = true
  resource_types {
    service   = false
    container = false
    object    = true
  }
  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }
  start  = "2020–06–15"
  expiry = "2021–03–21"
  permissions {
    read    = true
    write   = false
    delete  = false
    list    = false
    add     = false
    create  = false
    update  = false
    process = false
  }
}

resource "azurerm_app_service" "app" {
  name                = "${var.app_name}-${var.environement}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  app_service_plan_id = azurerm_app_service_plan.plan-app.id

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "https://${data.azurerm_storage_account.storagezip.name}.blob.core.windows.net/app/myapp_v1.0.0/zip${data.azurerm_storage_account_sas.storage_sas.sas}"
  }
}


