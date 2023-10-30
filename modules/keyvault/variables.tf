
variable "name" {
  type = string
  description = "name of the resource type"
}

variable "default_tags" {
  type = map(string)
  description = "Deployment environment of the application, workload, or service. That are dev, test, uat and hotfix"
}

variable "resource_group_name" {
  type = string
  description = "the resource group name"
}

variable "location" {
  type = string
  description = "the location of the resource"
}

variable "aks_identity_principal_id" {
  type = string
  description = "Principal identifier of Managed Identity"
}

# # The Object ID of the Service Principal that Azure-cli runs as - used for adding to keyvault by DevOps
variable  "devops_azure_cli_sp" {
   default  = "c89dee23-4de4-4e11-8a09-d8a035a6e4a2"
   # c89dee23-4de4-4e11-8a09-d8a035a6e4a2 is object id of the service principal (enterprise apps)
}

variable "app_identity_principal_id" {
  type = string
  description = "Principal identifier of Managed Identity"
}

variable "key_vault_app" {
  type    = string
  default = "cbcde16b-43f8-47b2-b7bf-ecea22d5a3b8"
  # cbcde16b-43f8-47b2-b7bf-ecea22d5a3b8 is object id of sp-mapps (enterpise apps)
}

# # Key vault administrators
variable "key_vault_administrators" {
  type    = list(string)
  default = ["904f3e6c-0c20-4536-b5ba-73b8b8575993", "d0f9d95a-fdc1-4766-b366-70203f868247"]
  # 904f3e6c-0c20-4536-b5ba-73b8b8575993 is object id of Nam Tran Phuong (Owner)
  # d0f9d95a-fdc1-4766-b366-70203f868247 is object id of Nam Tran (Member)
  
}