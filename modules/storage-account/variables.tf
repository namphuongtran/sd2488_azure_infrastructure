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

variable "is_hns_enabled" {
  type = bool
  default = false
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2"
}

variable "create_storage_share" {
  type = bool
  default = false
  description = "Determines whether create storage share or not"
}

variable "storage_shares" {
  type = map(object({
    name = string
    quota = number
  }))

  description = "The object to be created file share"
}