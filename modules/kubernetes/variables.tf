# define variables 
variable "name" {
  type = string
  description = "name of the resource type"
}

variable "node_resource_group" {
  type = string
  description = "Name of the workload the resource supports."
}

variable "resource_group_name" {
  type = string
  description = "the resource group name"
}

variable "resource_group_id" {
  type = string
  description = "the resource group id"
}

variable "location" {
  type = string
  description = "the location of the resource"
}

variable "role_based_access_control_enabled" {
  type = bool
  description = "the short name for the location"
  default = true
}

variable "container_id" {
  type = string
  description = "The container id."
}

variable "default_tags" {
  type = map(string)
  description = "Business impact of the resource or supported workload."
}

variable "log_analytics_workspace_id" {
  type = string
  description = "The log analytics workspace id to store all the log information of AKS"
}

variable "vnet_subnet_id" {
  type = string
  description = "The subnet for AKS Id"
}

variable "vnet" {
  type = object({})
  description = "Virtual Network that AKS depends on"
}

variable "agw"{
  type = object({})
  description = "Application Gateway that AKS depends on"
}

variable "agw_id" {
  type = string
  description = "Application Gateway Id"
}

variable "aksid_id" {
  type = string
  description = "The user managed Identity id"
}

variable "aksid_principal_id" {
  type = string
  description = "The user managed Identity of principal id"
}

variable "aksid" {
  type = object({})
  description = "The user managed identity of AKS that role assigment needs to be dependent on"
}

variable "admin_group_id" {
    type = string
    description = "The admin group id which includes all members need to admintratively"
}

# object ID of the tenant. The Tenant of Azure Active Directory
variable "tenant_id" {
  description = "The Tenant ID of Azure Active Directory which is located in the Basic information"
  default = "cd885c9a-f02a-4c1f-b3e8-f89fd0a9c165"  
}

variable "aks_dns_prefix" {
  description = "Optional DNS prefix to use with hosted Kubernetes API server FQDN."
  default     = "aks"
}

variable "os_disk_size" {
  description = "Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 applies the default disk size for that agentVMSize."
  default     = 128
}

variable "node_count" {
  description = "The number of agent nodes for the cluster."
  default     = 1 # should be default is 2 but for saving cost we set it 1
}

variable "aks_agent_count_windows" {
  description = "The number of Windows agent nodes for the cluster."
  default     = 0
}

variable "system_vm_size" {
  description = "The size of the Virtual Machine."
  default     = "Standard_D2_v2"
}

variable "user_vm_size" {
  description = "The size of the Virtual Machine."
  default     = "Standard_D1_v2"
}

variable "max_pods" {
  description = "The maximum number of pods per node"
  default = 250
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}
variable "service_cidr" {
  description = "A CIDR notation IP range from which to assign service cluster IPs."
  default     = "10.0.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "Containers DNS server IP address."
  default     = "10.0.0.10"
}

variable "aks_docker_bridge_cidr" {
  description = "A CIDR notation IP for Docker bridge."
  default     = "172.17.0.1/16"
}

variable  "devops_azure_cli_sp" {
  description = "The Object ID of the Service Principal that Azure-cli runs as"
   default  = "53e29ca5-77b4-47b9-9893-d4bcd70ab91c"
   # This is object id of sp-nash-non-prod-devops (enterprise apps)
}

#Azure Kubernetes Service RBAC Admins
variable "azure_kubernetes_rbac_administrators" {
  type    = set(string)
  default = ["f8535c5c-e019-4c9b-87d3-c53ba6653576","904f3e6c-0c20-4536-b5ba-73b8b8575993"]
}

#Azure Kubernetes Service RBAC Cluster Admins
variable "azure_kubernetes_rbac_cluster_administrators" {
  type    = set(string)
  default = ["f8535c5c-e019-4c9b-87d3-c53ba6653576","904f3e6c-0c20-4536-b5ba-73b8b8575993"]
}

variable "authorized_ip_ranges" {
  default =[       
          #"14.232.228.201/32"       # Nam's House
  ]
}