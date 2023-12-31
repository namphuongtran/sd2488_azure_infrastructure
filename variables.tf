variable "region" {
  type        = string
  description = "the region that resource will be deployed"
  default     = "southeastasia"
}

variable "location" {
  type        = string
  description = "the short name for the location"
  default     = "ase"
}

variable "region_failover" {
  type        = string
  description = "the region that resource will be deployed"
  default     = "eastasia"
}

variable "region_short_failover" {
  type        = string
  description = "the short name for the location"
  default     = "asa"
}

variable "region_short_group" {
  type        = string
  description = "the short name for the location"
  default     = "as"
}

variable "admin_group_id" {
  type        = string
  description = "The admin group id."
  default = "2d53ffff-d3cc-4b0a-89f9-e52e8c6a59e7"
}

variable "applications" {
  type        = set(string)
  description = "Name of the workload the resource supports."
  default = [
    "prj"
  ]
}

variable "disaster_recovery" {
  type    = string
  default = "Critical"
}

variable "instance" {
  type    = string
  default = "001"
}

variable "default_tags" {
  default     = {
    OpsTeam                = "MSP-Terraform"
    Owner                  = "Nam Phuong Tran"
    Criticality            = "High"
    OpsCommitment          = "Workload Operations"
    Environment            = "dev"
    ApplicationName        = "pisharp"
    Description            = "Managed by Terraform"
  }
  description = "The default project tags"
  type        = map(string)
}

variable "application" {
  description = "Name of the Application"
  default = "pisharp"
  type = string
}

variable "environment" {
  description = "The environment name of the application"
  type = string
  default = "dev"
}

variable "ip_configuration_name" {
  description = "The enterpise app object id as service principle"
  default     = "ip-configuration-name"
  type = string
}

variable "storage_shares" {
  type = map(object({
    name = string
    quota = number
  }))
  default = {
    "grafana" = {
      name = "grafana"
      quota = 50
    },
    "prometheus" = {
      name = "prometheus"
      quota = 50
    }
  }
}