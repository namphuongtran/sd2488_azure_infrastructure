resource "azurerm_application_insights" "appi" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = var.application_type
  sampling_percentage = var.sampling_percentage
  workspace_id        = var.log_analytics_workspace_id

  depends_on = [var.log_analytics_workspace]

  tags = merge(var.default_tags, {

  })
}