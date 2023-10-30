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
  description = "the default tags for the resource"
}

variable "application_type" {
  type = string
  description = "The application type."
  default = "web"
}

variable "sampling_percentage" {
  type = number
  description = "Owner of the application, workload, or service."
  default = 100
}

variable log_analytics_workspace_id {
  type = string
  description = "Log Analytics Workspace Id"
}

variable "log_analytics_workspace" {
  type = object({})
  description = "Log Analytics Workspace"
}