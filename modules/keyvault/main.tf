data "azurerm_client_config" "current" {

}

resource "azurerm_key_vault" "kv" {  
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"


  lifecycle {
    # prevent_destroy = true
  }

dynamic "access_policy" {
    for_each = [var.devops_azure_cli_sp]
    
    content {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = access_policy.value
        key_permissions = [
          "Get",
          "List",
          "Purge",
          "Create",
          "Update",
        ]

        secret_permissions = [
          "Get",
          "List",
          "Delete",
          "Set",
          "Purge",
        ]

        storage_permissions = [
          "Get",
          "List",
          "Set",
        ]
      

        certificate_permissions = [
          "Get",
          "List",
          "Create",
          "Purge",
          "Import",
          "Update",
        ]
      }
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.aks_identity_principal_id 
    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Get",
      "List",
    ]

    storage_permissions = [
      "Get",
      "List",
    ]
  

    certificate_permissions = [
      "Get",
      "List",
    ]
  }


  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.app_identity_principal_id 
    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Get",
      "List",
    ]

    storage_permissions = [
      "Get",
      "List",
    ]
  

    certificate_permissions = [
      "Get",
      "List",
    ]
  }


  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.key_vault_app 
    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Get",
      "List",
    ]

    storage_permissions = [
      "Get",
      "List",
    ]
  

    certificate_permissions = [
      "Get",
      "List",
    ]
  }


  dynamic "access_policy" {
      for_each = var.key_vault_administrators
      content {
          tenant_id = data.azurerm_client_config.current.tenant_id
          object_id = access_policy.value
          key_permissions = [
            "Get",
            "List",
            "Purge",
            "Create",
            "Update",
            "Backup",
            "Restore",
            "Decrypt",
            "Encrypt",
            "Import",
            "Recover",
            "Verify"
          ]

          secret_permissions = [
            "Get",
            "List",
            "Delete",
            "Set",
            "Recover",
            "Restore",
            "Backup",
            "Purge"
          ]

          storage_permissions = [
            "Get",
            "List",
          ]
        

          certificate_permissions = [
            "Get",
            "List",
            "Create",
            "Delete",
            "Purge",
            "Recover",
            "Backup",
            "Import",
            "Restore",
            "Update",
          ]
        }
  }
  
  tags = merge(var.default_tags,{
    
  }) 
}

