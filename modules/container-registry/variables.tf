variable "name" {
  type = string
  description = "name of the resource type"
}


variable "sku" {
  type = string
  description = "Name of the workload the resource supports."
  default = "Basic"
}

variable "resource_group_name" {
  type = string
  description = "the resource group name"
}

variable "location" {
  type = string
  description = "the location of the resource"
}

variable "default_tags" {
  type = map(string)
  description = "the default tags of the resource"
}

variable "azure_kubernetes_rbac_administrators" {
  type    = set(string)
  default = ["a47b8321-604b-4c06-8672-ab68441cfc5b"]
}