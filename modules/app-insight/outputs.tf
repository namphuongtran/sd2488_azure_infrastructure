output "insights_connection_string" {
  value = azurerm_application_insights.appi.connection_string
}

output "insights_key" {
  value = azurerm_application_insights.appi.instrumentation_key
}

output "appi" {
  value = azurerm_application_insights.appi
}