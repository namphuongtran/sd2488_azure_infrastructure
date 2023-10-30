resource "azurerm_virtual_network" "vnet" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  address_space            = [var.virtual_network_address_prefix]

  tags = merge(var.default_tags,{
    
  }) 
}

resource "azurerm_subnet" "private_subnet" {
  name                   = var.aks_subnet_name
  virtual_network_name   = azurerm_virtual_network.vnet.name
  resource_group_name    = var.resource_group_name 
  address_prefixes     = ["10.51.0.0/16"]
  depends_on             = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "public_subnet" {
  name                  = var.agw_subnet_name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  resource_group_name   = var.resource_group_name 
  address_prefixes     = ["10.52.0.0/16"]
  depends_on            = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "database_subnet" {
  name                   = var.database_subnet_name
  virtual_network_name   = azurerm_virtual_network.vnet.name
  resource_group_name    = var.resource_group_name 
  address_prefixes     = ["10.53.0.0/16"]
  depends_on             = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "bastion_subnet" {
  name                   = var.bastion_subnet_name
  virtual_network_name   = azurerm_virtual_network.vnet.name
  resource_group_name    = var.resource_group_name 
  address_prefixes     = ["10.54.0.0/16"]
  depends_on             = [azurerm_virtual_network.vnet]
}

resource "azurerm_network_security_group" "nsg" {
  name                            = var.nsg_name
  resource_group_name             = var.resource_group_name
  location                        = var.location 

  tags = merge(var.default_tags,{
    
  })
}

resource "azurerm_network_interface" "nic" {
  name                            = var.nic_name
  resource_group_name             = var.resource_group_name
  location                        = var.location 

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.private_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "nsgnic" {
  network_interface_id            = azurerm_network_interface.nic.id
  network_security_group_id       = azurerm_network_security_group.nsg.id
}

