output "app_service_names"{
    value = azurerm_app_service.app.*.name
}