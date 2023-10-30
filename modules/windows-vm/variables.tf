# define variables 
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

variable "network_interface_id" {
  type = string
  description = "The network interface "
}