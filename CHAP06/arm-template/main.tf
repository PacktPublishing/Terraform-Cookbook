
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg-app" {
  name     = "RG-DEMO"
  location = "westeurope"
}

resource "azurerm_app_service_plan" "plan-app" {
  name                = "SPDemo"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg-app.name

  sku {
    tier = "Standard"
    size = "S1"
  }

}

resource "azurerm_app_service" "app" {
  name                = "AppDemoARM"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg-app.name
  app_service_plan_id = azurerm_app_service_plan.plan-app.id
}


resource "azurerm_template_deployment" "extension" {
  name                = "extension"
  resource_group_name = azurerm_resource_group.rg-app.name
  template_body       = file("ARM_siteExtension.json")

  parameters = {
    appserviceName   = azurerm_app_service.app.name
    extensionName    = "AspNetCoreRuntime.2.2.x64"
    extensionVersion = "2.2.0-preview3-35497"
  }

  deployment_mode = "Incremental"
}