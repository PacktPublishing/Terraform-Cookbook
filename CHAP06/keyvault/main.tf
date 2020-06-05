
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}



data "azurerm_key_vault" "keyvault" {
  name                = "keyvdemobook"
  resource_group_name = "rg_keyvault"
}

data "azurerm_key_vault_secret" "app-connectionstring" {
  name         = "ConnectionStringApp"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_resource_group" "rg-app" {
  name     = "RG-DEMOVAULT"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "plan-app" {
  name                = "SP-demovault"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "demovaultbook"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  app_service_plan_id = azurerm_app_service_plan.plan-app.id

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = data.azurerm_key_vault_secret.app-connectionstring.value
  }
}
