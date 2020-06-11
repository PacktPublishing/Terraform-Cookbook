provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "RG-VM"
  location = "West Europe"
}

resource "azurerm_public_ip" "ip" {
  name                = "vmdemo-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

data "azurerm_subnet" "subnet" {
  name                 = "Default1"
  resource_group_name  = "RG_NETWORK"
  virtual_network_name = "VNET-DEMO"
}

resource "azurerm_network_interface" "nic" {
  name                = "vmdemo-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip.id
  }
}


data "azurerm_key_vault" "keyvault" {
  name                = "keyvdemobook"
  resource_group_name = "rg_keyvault"
}

data "azurerm_key_vault_secret" "vm-password" {
  name         = "vmdemoaccess"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "myvmdemo"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = data.azurerm_key_vault_secret.vm-password.value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic.id]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  provisioner "remote-exec" {
    inline = [
      "apt update",
    ]

    connection {
      host     = self.public_ip_address
      user     = self.admin_username
      password = self.admin_password
    }
  }
}