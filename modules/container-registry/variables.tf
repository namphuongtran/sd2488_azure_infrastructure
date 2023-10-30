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