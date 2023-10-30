resource "azurerm_storage_account" "st" {  
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  account_kind                    = "StorageV2"
  is_hns_enabled                  = var.is_hns_enabled
  
  static_website {
    error_404_document = "errors.html"
    index_document     = "index.html"
  }

  tags = merge(var.default_tags,{
    
  })
}

resource "azurerm_storage_share" "storage_share" {
  for_each = var.create_storage_share ? var.storage_shares: {}
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.st.name
  quota                = each.value.quota
}




