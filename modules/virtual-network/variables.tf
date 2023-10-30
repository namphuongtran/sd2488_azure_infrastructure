
variable "name" {
  type = string
  description = "name of the resource type"
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
  description = "the default tags."
}


variable "virtual_network_address_prefix" {
  type = string
  description = "Containers DNS server IP address."
  default     = "10.0.0.0/8"
}

variable "aks_subnet_name" {
  type = string
  description = "AKS Subnet Name."
  default     = "kubesubnet"
}

variable "agw_subnet_name" {
  type = string
  description = "Application gateway Subnet Name."
  default     = "appgwsubnet"
}

variable "bastion_subnet_name" {
  type = string
  description = "The bastion Subnet Name."
  default     = "AzureBastionSubnet"
}

variable "database_subnet_name" {
  type = string
  description = "Azure functions Subnet Name."
  default     = "azfunctions"
}

variable "nsg_name" {
  type = string
  description = "The network security name."
}

variable "aks_subnet_address_prefix" {
  type = string
  description = "Containers DNS server IP address."
  default     = "10.1.0.0/16"
}

variable "app_gateway_subnet_address_prefix" {
  type = string
  description = "Containers DNS server IP address."
  default     = "10.2.0.0/16"
}

variable "azfunctions_subnet_address_prefix" {
  type = string
  description = "Containers DNS server IP address."
  default     = "10.3.0.0/16"
}

variable "bastion_subnet_address_prefix" {
  type = string
  description = "Bastion DNS server IP address."
  default     = "10.4.0.0/16"
}

variable "db_subnet_address_prefix" {
  type = string
  description = "The database DNS server IP address."
  default     = "10.5.0.0/16"
}

variable "nic_name" {
  type = string
  description = "The Network interface name."
}

variable "ip_configuration_name" {
  type = string
  description = "The ip configuration name."
}