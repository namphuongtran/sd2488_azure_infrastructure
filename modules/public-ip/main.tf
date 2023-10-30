resource "azurerm_public_ip" "pip" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  allocation_method            = "Static"
  sku                          = "Standard"
  domain_name_label            = var.domain_name_label
  zones                        = ["1","2","3"]

   tags = merge(var.default_tags,{
   
  } )
}