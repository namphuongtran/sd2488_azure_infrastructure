resource "azurerm_application_gateway" "agw" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  enable_http2        = true

  lifecycle {
    # prevent_destroy = true
  }

  sku {
    name     = var.app_gateway_sku
    tier     = var.app_gateway_tier
  }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnet_appgwsubnet_id
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401S"
  }


  waf_configuration {
    enabled                  = true
    firewall_mode            = "Detection" #Prevention
    rule_set_type            = "OWASP"
    rule_set_version         = "3.0"
    file_upload_limit_mb     = "100"
    max_request_body_size_kb = "128"
    request_body_check       = true
  }


  frontend_port {
    name = var.frontend_port_name
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = var.publicip_id
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = var.listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.http_setting_name
    priority                   = 1000
  }

  tags = merge(var.default_tags, {
    
  }) 

  depends_on = [var.vnet, var.publicip]
}


resource "azurerm_monitor_diagnostic_setting" "diagnostic_appgateway" {
  name                       = "Log All Metrics"
  target_resource_id         = azurerm_application_gateway.agw.id
  log_analytics_workspace_id = var.workspace_id

  enabled_log {
    category = "ApplicationGatewayFirewallLog"
  }

  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }

  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }

  metric {
    category = "AllMetrics"
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }

}