output "subnets" {
  value = azurerm_subnet.subnet[*].name
}