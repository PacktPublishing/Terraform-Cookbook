resource "azurerm_app_service_plan" "plan-app" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan-app.id
  app_settings = {
    "INSTRUMENTATIONKEY" = azurerm_application_insights.appinsight-app.instrumentation_key
  }
}

resource "azurerm_application_insights" "appinsight-app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}
