data "azurerm_resource_group" "rg-name" {
    name = var.rg-name
  
}

data "azurerm_virtual_network" "vnet" {
    name = var.vnet-name
    resource_group_name = data.azurerm_resource_group.rg-name.name

  
}

data "azurerm_network_security_group" "nsg" {
    name = var.nsg-name
    resource_group_name = data.azurerm_resource_group.rg-name.name
  
}

data "azurerm_key_vault" "key-vault" {
    name = var.key-vault-name
    resource_group_name = data.azurerm_resource_group.rg-name.name  
    
}
data "azurerm_key_vault_secret" "vm_password" {
    name = "pawwsord"
    key_vault_id = data.azurerm_key_vault.key-vault.id

}