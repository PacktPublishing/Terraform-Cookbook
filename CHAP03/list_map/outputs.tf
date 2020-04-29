output "app_service_names" {
  value = [for x in azurerm_app_service.app : x.name]
}

output "app_service_urls" {
  value = {for x in azurerm_app_service.app :  x.name => x.default_site_hostname  }
}