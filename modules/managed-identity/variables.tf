variable "name" {
  type = string
  description = "name of the resource type"
}

variable "default_tags" {
  type = map(string)
  description = "The default tags"
}

variable "resource_group_name" {
  type = string
  description = "the resource group name"
}

variable "location" {
  type = string
  description = "the location of the resource"
}