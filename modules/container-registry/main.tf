resource "azurerm_container_registry" "acr" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.sku
  admin_enabled            = false

  tags = merge(var.default_tags,{
    
  })
}

resource "azurerm_role_assignment" "role_ass_acr" {
  for_each = var.azure_kubernetes_rbac_administrators
  scope                         = azurerm_container_registry.acr.id
  role_definition_name          = "Contributor"
  principal_id                  = each.value
}