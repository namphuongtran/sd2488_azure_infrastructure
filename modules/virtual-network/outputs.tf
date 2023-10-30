output "public_subnet_id" {
  value = azurerm_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private_subnet.id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion_subnet.id
}

output "database_subnet_id" {
  value = azurerm_subnet.database_subnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet" {
  value = azurerm_virtual_network.vnet
}

output "network_interface_id" {
  value = azurerm_network_interface.nic.id
}