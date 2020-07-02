terraform {
  backend "azurerm" {}
}


resource "random_string" "random" {
  length  = 8
  special = true
}

output "str" {
  value = random_string.random.result
}