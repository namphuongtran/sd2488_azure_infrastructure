variable "name" {
  type = string
  description = "name of the resource type"
}

variable "default_tags" {
  type = map(string)
  description = "The default tags for the resource"
}

variable "resource_group_name" {
  type = string
  description = "the resource group name"
}

variable "location" {
  type = string
  description = "the location of the resource"
}

# # refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
  type = string
  default = "PerGB2018"
}