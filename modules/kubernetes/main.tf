resource "azurerm_kubernetes_cluster" "aks" {
  name                              = var.name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  dns_prefix                        = var.aks_dns_prefix
  role_based_access_control_enabled = var.role_based_access_control_enabled
  kubernetes_version                = "1.27.3"
  lifecycle {
    # prevent_destroy = true
    ignore_changes = [network_profile, default_node_pool, microsoft_defender, azure_policy_enabled]
  }

  node_resource_group = var.node_resource_group

  azure_active_directory_role_based_access_control {
    admin_group_object_ids = [var.admin_group_id]
    azure_rbac_enabled     = true
    managed                = true
    tenant_id              = var.tenant_id
  }

  http_application_routing_enabled = false
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  api_server_access_profile {
    authorized_ip_ranges = var.authorized_ip_ranges
  }

  default_node_pool {
    name                  = "system"
    enable_auto_scaling   = "false"
    enable_node_public_ip = "false"
    max_pods              = var.max_pods
    node_count            = var.node_count
    vm_size               = var.system_vm_size
    os_disk_size_gb = var.os_disk_size
    vnet_subnet_id  = var.vnet_subnet_id
    zones               = ["3"]#Message="The VM size of Standard_D3_v2 is only allowed  in zones [2] in your subscription in location 'westeurope'. "
    type = "VirtualMachineScaleSets"
  }


  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy     = "azure"
    dns_service_ip = var.aks_dns_service_ip
    service_cidr = var.service_cidr
    
  }

  depends_on = [var.vnet, var.agw]
  tags = merge(var.default_tags, {

  })
}

resource "azurerm_kubernetes_cluster_node_pool" "application" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = "user"
  enable_auto_scaling   = "false"
  enable_node_public_ip = "false"
  max_pods              = var.max_pods
  node_count            = var.node_count
  vm_size               = var.user_vm_size
  os_disk_size_gb       = var.os_disk_size
  vnet_subnet_id        = var.vnet_subnet_id
  mode                  = "User"
  zones               = ["3"]
  lifecycle {
    # prevent_destroy = true
  }

  tags = merge(var.default_tags, {
  })
}

data "azurerm_resource_group" "node_rg" {
  name = azurerm_kubernetes_cluster.aks.node_resource_group
}

data "azurerm_kubernetes_cluster" "kubelet_identity" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = azurerm_kubernetes_cluster.aks.resource_group_name
  depends_on          = [var.vnet, azurerm_kubernetes_cluster.aks]

}

resource "azurerm_role_assignment" "ra_network" {
  scope                = var.vnet_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  depends_on           = [var.vnet]
}

resource "azurerm_role_assignment" "ra_managed_identity" {
  scope                = var.aksid_id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  depends_on           = [var.aksid]
}

resource "azurerm_role_assignment" "ra_agw" {
  scope                = var.agw_id
  role_definition_name = "Contributor"
  principal_id         = var.aksid_principal_id
  depends_on           = [var.aksid, var.vnet]
}

resource "azurerm_role_assignment" "ra_rg" {
  scope                = var.resource_group_id
  role_definition_name = "Reader"
  principal_id         = var.aksid_principal_id
  depends_on           = [var.aksid, var.vnet]
}

resource "azurerm_role_assignment" "ra_node_group" {
  scope                = data.azurerm_resource_group.node_rg.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = data.azurerm_kubernetes_cluster.kubelet_identity.kubelet_identity[0].object_id
  depends_on           = [var.vnet, data.azurerm_kubernetes_cluster.kubelet_identity, azurerm_kubernetes_cluster.aks]
  lifecycle {
    ignore_changes = [scope, principal_id]
  }
}

resource "azurerm_role_assignment" "ra_vm" {
  scope                = data.azurerm_resource_group.node_rg.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = data.azurerm_kubernetes_cluster.kubelet_identity.kubelet_identity[0].object_id
  depends_on           = [var.vnet, data.azurerm_kubernetes_cluster.kubelet_identity, azurerm_kubernetes_cluster.aks]
  lifecycle {
    ignore_changes = [scope, principal_id]
  }
}

resource "azurerm_role_assignment" "ra_node_group_access_by_devops_cli" {
  scope                = data.azurerm_resource_group.node_rg.id
  role_definition_name = "Contributor"
  principal_id         = var.devops_azure_cli_sp
  depends_on           = [var.vnet, data.azurerm_kubernetes_cluster.kubelet_identity, azurerm_kubernetes_cluster.aks, data.azurerm_resource_group.node_rg]
  lifecycle {
    ignore_changes = [scope, principal_id]
  }
}

resource "azurerm_role_assignment" "ra_rg_managed_identity" {
  scope                = var.resource_group_id
  role_definition_name = "Managed Identity Operator"
  principal_id         = data.azurerm_kubernetes_cluster.kubelet_identity.kubelet_identity[0].object_id
  depends_on           = [var.vnet, data.azurerm_kubernetes_cluster.kubelet_identity, azurerm_kubernetes_cluster.aks]
  lifecycle {
    ignore_changes = [scope, principal_id]
  }
}

resource "azurerm_role_assignment" "ra_aks_rbac" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = var.devops_azure_cli_sp
  depends_on           = [var.vnet, data.azurerm_kubernetes_cluster.kubelet_identity, azurerm_kubernetes_cluster.aks]
  lifecycle {
    ignore_changes = [scope, principal_id]
  }
}

resource "azurerm_role_assignment" "ra_aks_cluster_rbac" {
  for_each             = var.azure_kubernetes_rbac_cluster_administrators
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = each.value
  depends_on           = [var.vnet, data.azurerm_kubernetes_cluster.kubelet_identity, azurerm_kubernetes_cluster.aks]
  lifecycle {
    ignore_changes = [scope, principal_id]
  }
}

resource "azurerm_role_assignment" "acr-assignment" {
  scope                = var.container_id
  role_definition_name = "ACRPull"
  principal_id         = data.azurerm_kubernetes_cluster.kubelet_identity.kubelet_identity[0].object_id
  lifecycle {
    ignore_changes = [scope, principal_id]
  }
}
