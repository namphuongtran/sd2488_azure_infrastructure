module "rg" {
  source       = "./modules/resource-group"
  name         = join("-", ["rg", var.application, var.environment, var.location])
  location     = var.region
  default_tags = var.default_tags
}

module "id-aks" {
  source              = "./modules/managed-identity"
  name                = join("-", ["id", var.application, var.environment, var.location])
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  default_tags        = var.default_tags
}

module "logs" {
  source              = "./modules/log-analytics"
  name                = join("-", ["log", var.application, var.environment, var.location])
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  default_tags        = var.default_tags
}

module "appi" {
  source                     = "./modules/app-insight"
  name                       = join("-", ["appi", var.application, var.environment, var.location])
  location                   = module.rg.resource_group_location
  resource_group_name        = module.rg.resource_group_name
  default_tags               = var.default_tags
  log_analytics_workspace_id = module.logs.log_analytics_workspace_id
  log_analytics_workspace    = module.logs.log_analytics_workspace
}

module "acr" {
  source              = "./modules/container-registry"
  name                = join("", ["cr", var.application, var.environment, var.location])
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  default_tags        = var.default_tags
}

module "vnet" {
  source = "./modules/virtual-network"

  name                  = join("-", ["vnet", var.application, var.environment, var.location])
  location              = module.rg.resource_group_location
  resource_group_name   = module.rg.resource_group_name
  nsg_name              = join("-", ["nsg", var.application, var.environment, var.location])
  nic_name              = join("-", ["nic", var.application, var.environment, var.location])
  ip_configuration_name = var.ip_configuration_name
  default_tags          = var.default_tags
}

module "pip_agw" {
  source              = "./modules/public-ip"
  name                = join("-", ["pip", "agw", var.application, var.environment, var.location])
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  domain_name_label   = join("-", ["dnl", "agw", var.application, var.environment, var.location])
  default_tags        = var.default_tags
}

module "pip_bas" {
  source              = "./modules/public-ip"
  name                = join("-", ["pip", "bas", var.application, var.environment, var.location])
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  domain_name_label   = join("-", ["dnl", "bas", var.application, var.environment, var.location])
  default_tags        = var.default_tags
}

module "bas" {
  source                = "./modules/bastion-host"
  name                  = join("-", ["bas", var.application, var.environment, var.location])
  location              = module.rg.resource_group_location
  resource_group_name   = module.rg.resource_group_name
  ip_configuration_name = var.ip_configuration_name
  default_tags          = var.default_tags
  subnet_id             = module.vnet.bastion_subnet_id
  public_ip_address_id  = module.pip_bas.public_ip_id
}

module "win_vm" {
  source               = "./modules/windows-vm"
  name                 = join("-", ["vm", var.application, var.environment])
  location             = module.rg.resource_group_location
  resource_group_name  = module.rg.resource_group_name
  default_tags         = var.default_tags
  network_interface_id = module.vnet.network_interface_id
}

locals {
  backend_address_pool_name      = "${module.vnet.vnet_name}-beap"
  frontend_port_name             = "${module.vnet.vnet_name}-feport"
  frontend_ip_configuration_name = "${module.vnet.vnet_name}-feip"
  http_setting_name              = "${module.vnet.vnet_name}-be-htst"
  listener_name                  = "${module.vnet.vnet_name}-httplstn"
  request_routing_rule_name      = "${module.vnet.vnet_name}-rqrt"
  app_gateway_subnet_name        = "appgwsubnet"
}

module "agw" {
  source                         = "./modules/app-gateway"
  name                           = join("-", ["agw", var.application, var.environment, var.location])
  location                       = module.rg.resource_group_location
  resource_group_name            = module.rg.resource_group_name
  frontend_ip_configuration_name = local.frontend_ip_configuration_name
  backend_address_pool_name      = local.backend_address_pool_name
  frontend_port_name             = local.frontend_port_name
  http_setting_name              = local.http_setting_name
  listener_name                  = local.listener_name
  request_routing_rule_name      = local.request_routing_rule_name
  publicip                       = module.pip_agw
  publicip_id                    = module.pip_agw.public_ip_id
  subnet_appgwsubnet_id          = module.vnet.public_subnet_id
  workspace_id                   = module.logs.log_analytics_workspace_id
  vnet                           = module.vnet
  default_tags                   = var.default_tags
}

module "st" {
  source              = "./modules/storage-account"
  name                = join("", ["st", var.application, var.environment, var.location])
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  default_tags        = var.default_tags
  storage_shares      = var.storage_shares
}

module "aks" {
  source                     = "./modules/kubernetes"
  name                       = join("-", ["aks", var.application, var.environment, var.location])
  node_resource_group        = join("-", ["rg", "aks", "managed", var.environment, var.location])
  location                   = module.rg.resource_group_location
  resource_group_name        = module.rg.resource_group_name
  resource_group_id          = module.rg.resource_group_id
  vnet_subnet_id             = module.vnet.private_subnet_id
  admin_group_id             = var.admin_group_id
  vnet                       = module.vnet.vnet
  agw                        = module.agw.appgw
  agw_id                     = module.agw.appgw_id
  aksid_id                   = module.id-aks.identity_id
  aksid_principal_id         = module.id-aks.identity_principal_id
  aksid                      = module.id-aks
  log_analytics_workspace_id = module.logs.log_analytics_workspace_id
  container_id               = module.acr.container_id
  default_tags               = var.default_tags
}