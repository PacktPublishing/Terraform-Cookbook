output "app_service_names" {
  value = [for app in azurerm_app_service.app : app.name]
}

output "app_service_urls" {
  value = { for app in azurerm_app_service.app : app.name => app.default_site_hostname }
}