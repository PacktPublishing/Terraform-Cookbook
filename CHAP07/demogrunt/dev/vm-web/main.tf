provider "azurerm" {
  features {}
}



data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
}


module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = var.resource_group_name
  vm_os_simple        = "UbuntuServer"
  vnet_subnet_id      = data.azurerm_subnet.subnet.id
}