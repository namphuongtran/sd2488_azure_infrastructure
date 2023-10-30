variable "name" {
  type = string
  description = "name of the resource type"
}

variable "default_tags" {
  type = map(string)
  description = "The default tags"
}

variable "ip_configuration_name" {
  type = string
  description = "The Name of IP configuration"
}

variable "resource_group_name" {
  type = string
  description = "the resource group name"
}

variable "location" {
  type = string
  description = "the location of the resource"
}


variable "subnet_id" {
  type = string
  description = "The Subnet Id."
}

variable "public_ip_address_id" {
  type = string
  description = "Public IP Address"
}