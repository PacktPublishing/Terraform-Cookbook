
output "webapp_name" {
  value = "${azurerm_app_service.app.name}"
}

output "instrumentation_key" {
  value = "${azurerm_application_insights.appinsight-app.instrumentation_key}"
}
