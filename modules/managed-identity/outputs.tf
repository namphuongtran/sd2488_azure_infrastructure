output "identity_principal_id" {
  value = azurerm_user_assigned_identity.id.principal_id
}

output "identity_id" {
  value = azurerm_user_assigned_identity.id.id
}

output "identity_client_id" {
  value = azurerm_user_assigned_identity.id.client_id
}