resource "azurerm_resource_group" "rgtodo" {
    name = var.rg_name
    location = var.rg_location
}