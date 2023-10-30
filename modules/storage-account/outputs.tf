output "storage_account_id" {
  value = azurerm_storage_account.st.id
}

output "storage_account_name" {
  value = azurerm_storage_account.st.name
}

output "storage_account_access_key" {
  value = azurerm_storage_account.st.primary_access_key
}