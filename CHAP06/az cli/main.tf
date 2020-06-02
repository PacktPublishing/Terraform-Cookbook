

terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-demo-azcli"
  location = "westeurope"
}

resource "azurerm_storage_account" "sa" {
  name                     = "saazclidemo"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "westeurope"
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "GRS"
}

resource "null_resource" "webapp_static_website" {
  triggers = {
    account = azurerm_storage_account.sa.name
  }

  provisioner "local-exec" {
    command = "az storage blob service-properties update --account-name ${azurerm_storage_account.sa.name} --static-website true --index-document index.html --404-document 404.html"
  }
}



