resource "azurerm_app_service" "app" {
  name                = "${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  app_service_plan_id = azurerm_app_service_plan.plan-app.id

  app_settings = merge(local.common_app_settings, var.custom_app_settings)

  site_config {
    dotnet_framework_version = "v4.0"
  }

  tags = {
    ENV       = var.environment
    CreatedBy = var.createdby
  }
}



output "webapp_name" {
  description = "output Name of the webapp"
  value       = azurerm_app_service.app.name
}
