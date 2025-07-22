resource "azurerm_subnet" "subnet" {
    name = var.subnet_name
    resource_group_name = data.azurerm_resource_group.rg-name.name
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    address_prefixes = var.subnet-ipaddress
 
}

resource "azurerm_public_ip" "pip" {
  name = var.pip-name
  location = data.azurerm_resource_group.rg-name.location
  resource_group_name = data.azurerm_resource_group.rg-name.name
  allocation_method = "Static"
}

resource "azurerm_network_interface" "nic" {
    name = var.nic-name
    location =  data.azurerm_resource_group.rg-name.location
    resource_group_name =  data.azurerm_resource_group.rg-name.name
    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"


    }
  
}

resource "azurerm_network_interface_security_group_association" "nsg-nic-association" {

    network_interface_id =  azurerm_network_interface.nic.id
    network_security_group_id = data.azurerm_network_security_group.nsg.id
  
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm-name
  resource_group_name = data.azurerm_resource_group.rg-name.name
  location            = data.azurerm_resource_group.rg-name.location
  size                = var.vm-size
  admin_username      = var.vm-username

 admin_password = data.azurerm_key_vault_secret.vm_password.value
 disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id, 
  ]
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.vm-version
  }
}
  
