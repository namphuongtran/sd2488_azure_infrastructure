output "resource_group_name" {
  value = module.rg.resource_group_name
}

output "log_workspace_id" {
  value = module.logs.log_analytics_workspace_id
}

output "log_workspace" {
  value = module.logs.log_analytics_workspace
  sensitive = true
}

