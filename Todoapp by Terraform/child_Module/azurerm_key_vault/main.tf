resource "azurerm_key_vault" "kv" {
  name                        = var.key-vault-name
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  sku_name                    = "standard"
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "get",
      "set",
      "list",
      "delete",
    ]
  }
}



resource "azurerm_key_vault_secret" "vm_password_secret" {
  name         = "password"
  value        = "Auth@12345678"
  key_vault_id = azurerm_key_vault.kv.id
}