
resource "azurerm_user_assigned_identity" "id" {  
  name                = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location 

  tags = merge(var.default_tags, {
    
  }) 

}


