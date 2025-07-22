resource "azurerm_mssql_server" "sql-server" {
  name                         = var.mysql-server-name
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = data.azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql-server-user-name
  administrator_login_password = var.sql-server-passward
  minimum_tls_version          = "1.2"
 
}

resource "azurerm_mssql_database" "sql-database" {
  name         = var.sql-database-name
  server_id    = azurerm_mssql_server.sql-server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

}