resource "azurerm_app_configuration" "appcs" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku 

  tags = merge(var.default_tags, {})
}