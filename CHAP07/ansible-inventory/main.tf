variable "virtual_machines" {
  default = [
    {
      dns        = "test1.test.cloud"
      index      = "01"
      address_ip = "0.0.0.1"
    }
  ]
}


provider "azurerm" {
  features {}
}

variable "vmhosts" {
  type    = list(string)
  default = ["vmwebdemo1", "vmwebdemo2"]
}

resource "azurerm_resource_group" "rg" {
  location = "westeurope"
  name     = "rg-ansible-inventory"
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.rg.name
  subnet_prefixes     = ["10.0.2.0/24"]
  subnet_names        = ["subnet1"]
}

module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.rg.name
  vm_os_simple        = "UbuntuServer"
  nb_instances        = 2
  nb_public_ip        = 2
  vm_hostname         = "vmwebdemo"
  public_ip_dns       = var.vmhosts
  vnet_subnet_id      = module.network.vnet_subnets[0]
}



resource "local_file" "inventory" {
  filename = "inventory"
  content = templatefile("template-inventory.tpl",
    {
      vm_dnshost = zipmap(var.vmhosts, module.linuxservers.network_interface_private_ip)
  })
  depends_on = [module.linuxservers]
}

output "ips" {
  value = module.linuxservers.public_ip_address
}

output "dns" {
  value = module.linuxservers.public_ip_dns_name
}

output "test" {
  value = zipmap(var.vmhosts, module.linuxservers.network_interface_private_ip)
}