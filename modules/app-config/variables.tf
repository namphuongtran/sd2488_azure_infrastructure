# define variables 
variable "name" {
  type        = string
  description = "name of the resource type"
}

variable "resource_group_name" {
  type        = string
  description = "the resource group name"
}

variable "location" {
  type        = string
  description = "the location of the resource"
}

variable "default_tags" {
  type = map(string)
  description = "The default tags for the resource"
}

variable "sku" {
  type        = string
  default     = "free" #If launch to production it should be changed to Standard
  description = "The pricing tiers"
}