module "rg" {
    source = "../Child_Module/Azurerm_resource_group"
    rg_name = "todo-rg-prashant"
    rg_location = "Norway East"
  
}

module "key-vault" {
    source = "../child_Module/azurerm_key_vault"
    rg-name = "todo-rg-prashant" 
    key-vault-name =  "toco-key-vault"
    depends_on = [ module.rg ]
}


module "vnet" {
    depends_on = [module.key-vault ]
    source = "../child_Module/azurerm_vnet"
    vnet_name = "todo-vnet-prashant"
    address_space = ["10.0.0.0/16"]
    resource_group_name = "todo-rg-prashant"
  
}

module "nsg" {
    depends_on = [ module.vnet ]
    source = "../child_Module/azurerm_nsg"
    rg-name = "todo-rg-prashant"
    nsg-name = "nsgtodo-prashant" 
    nsg-rule-name =  "nsgrule-prashant"
    destination_port_ranges =  ["22","80"]
  
}

module "vm-frontend" {
    depends_on = [ module.nsg ]
  source = "../child_Module/azure_virtual_machine"
  subnet_name = "frontend-subnet"
  rg-name = "todo-rg-prashant"
  vnet-name = "todo-vnet-prashant"
  subnet-ipaddress = [ "10.0.0.0/24" ]
  pip-name = "fronted-pip"
  nic-name = "frontend-nic"
  nsg-name = "nsgtodo-prashant"
  vm-name = "fronted-vm"
  vm-size = "Standard_F2"
   key-vault-name ="todo-app"
 vm-username = "prashantadmin"
 publisher = "canonical"
 offer = "ubuntu-24_04-lts"
  sku       = "ubuntu-pro-gen1"
 vm-version = "latest"
}

module "vm-backend" {
    depends_on = [ module.nsg ]
  source = "../child_Module/azure_virtual_machine"
  subnet_name = "backend-subnet"
  rg-name = "todo-rg-prashant"
  vnet-name = "todo-vnet-prashant"
  subnet-ipaddress = [ "10.0.1.0/24" ]
  pip-name = "backend-pip"
  nic-name = "backend-nic"
  nsg-name = "nsgtodo-prashant"
  vm-name = "backend-vm"
  vm-size = "Standard_F2"
 vm-username = "prashantadmin"
 key-vault-name ="todo-app"

 publisher = "canonical"
 offer = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts"
 vm-version = "latest"
}

module "sql" {
    depends_on = [ module.rg ]
    source = "../child_Module/azurerm_sql_server"
    rg-name =  "todo-rg-prashant"
    mysql-server-name =  "todo-server-prashant"
    sql-database-name =  "todo-database"
    sql-server-user-name =  "admin"
    sql-server-passward =  "Auth@12345"

  
}