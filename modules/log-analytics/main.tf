resource "azurerm_log_analytics_workspace" "log" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku                             = var.log_analytics_workspace_sku

  tags =merge(var.default_tags,{
    
  }) 
}


resource "azurerm_log_analytics_solution" "log" {
    solution_name         = "ContainerInsights"
    location              = var.location
    resource_group_name   = var.resource_group_name
    workspace_resource_id = azurerm_log_analytics_workspace.log.id
    workspace_name        = azurerm_log_analytics_workspace.log.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
    tags =merge(var.default_tags,{
    
  }) 
}