resource "azurerm_network_security_group" "nsg" {
name =  var.nsg-name
location =  data.azurerm_resource_group.rg.location
resource_group_name =  data.azurerm_resource_group.rg.name

  
}

resource "azurerm_network_security_rule" "nsg-rule" {
    network_security_group_name = azurerm_network_security_group.nsg.name
    name = var.nsg-rule-name
    resource_group_name =  data.azurerm_resource_group.rg.name
    protocol = "Tcp" 
    direction =  "Inbound"
    priority =  "100"
    access =  "Allow"
    source_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix  = "*"
    destination_port_ranges = var.destination_port_ranges


  
}