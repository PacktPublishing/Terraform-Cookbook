output "app_service_names" {
  value = [for x in azurerm_app_service.app : x.name]
}