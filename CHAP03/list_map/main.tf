
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-app" {
  name     = "${var.resource_groupe_name}-${var.environement}"
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
}


resource "azurerm_app_service" "app" {
  for_each = var.web_apps

  name                = each.value["name"]
  location            = lookup(each.value, "location", "West Europe")
  resource_group_name = azurerm_resource_group.rg-app.name
  app_service_plan_id = azurerm_app_service_plan.plan-app.id

  site_config {
    dotnet_framework_version = each.value["dotnet_framework_version"]
  }

  connection_string {
    name  = "DataBase"
    type  = "SQLServer"
    value = "Server=${each.value["serverdatabase_name"]};Integrated Security=SSPI"
  }
}
