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

variable "subnet_appgwsubnet_id" {
  type = string
  description = "The subnet to connect to Vnet"
}

variable "publicip_id" {
  type = string
  description = "The public IP infront of App Gateway"
}

variable "vnet" {
  type = object({})
  description = "Vnet object which needs to be depended on"
}

variable "publicip" {
  type = object({})
  description = "Public IP object which needs to be depended on"
}

variable "workspace_id" {
  type = string
  description = "The Logs Analytics Workspace Id"
}

variable "app_gateway_sku" {
  type = string
  description = "Name of the Application Gateway SKU."
  default = "WAF_v2"
}

variable "app_gateway_tier" {
  type = string
  description = "Tier of the Application Gateway SKU."
  default = "WAF_v2"
}

variable "frontend_port_name" {
  type = string
  description = "The Frontend port name"
}

variable "frontend_ip_configuration_name" {
  type = string
  description = "The Frontend ip configuration name"
}

variable "backend_address_pool_name" {
  type = string
  description = "The backend address pool name"
}

variable "http_setting_name" {
  type = string
  description = "The http setting name"  
}

variable "listener_name" {
  type = string
  description = "The listener  name"  
}

variable "request_routing_rule_name" {
  type = string
  description = "The request routing rule name"  
}

variable "default_tags" {
  type = map(string)
  description = "The default tags"
}