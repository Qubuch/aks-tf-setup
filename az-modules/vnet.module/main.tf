# Locals block for hardcoded names
locals {
  backend_address_pool_name      = try("${azurerm_virtual_network.vnet.name}-beap", "")
  frontend_ip_configuration_name = try("${azurerm_virtual_network.vnet.name}-feip", "")
  frontend_port_name             = try("${azurerm_virtual_network.vnet.name}-feport", "")
  http_setting_name              = try("${azurerm_virtual_network.vnet.name}-be-htst", "")
  listener_name                  = try("${azurerm_virtual_network.vnet.name}-httplstn", "")
  request_routing_rule_name      = try("${azurerm_virtual_network.vnet.name}-rqrt", "")
}

data "azurerm_resource_group" "vnet_001" {
  name = "spoke-rg"
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.virtual_network_address_space
  tags                = var.all_tags
}

resource "azurerm_subnet" "subnet" {
  for_each = { for subnet in var.subnets : subnet.name => subnet.address_prefixes }

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value
}

# resource "azurerm_network_security_group" "this" {
#   name                = "acceptanceSG1"
#   location            = data.azurerm_resource_group.vnet_001.location
#   resource_group_name = data.azurerm_resource_group.vnet_001.name

#   security_rule {
#     name                       = "test123"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   tags = var.all_tags
# }

# create a public IP for the LB
resource "azurerm_public_ip" "pip" {
  name                = "aks-lb"
  resource_group_name = data.azurerm_resource_group.vnet_001.name
  location            = data.azurerm_resource_group.vnet_001.location
  allocation_method   = "Static"

  tags = var.all_tags
}

resource "azurerm_subnet" "appgw" {
  address_prefixes     = ["10.30.3.0/24"]
  name                 = "aks-subnet-gw"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

# Decided to go with ingress instead of Application Gateway for now
resource "azurerm_application_gateway" "appgw" {
  location = var.location
  # We don't need the WAF for this simple example
  name                = "ingress"
  resource_group_name = var.resource_group_name

  backend_address_pool {
    name = local.backend_address_pool_name
  }
  backend_http_settings {
    cookie_based_affinity = "Disabled"
    name                  = local.http_setting_name
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }
  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip.id
  }
  frontend_port {
    name = local.frontend_port_name
    port = 80
  }
  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.appgw.id
  }
  http_listener {
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    name                           = local.listener_name
    protocol                       = "Http"
  }
  request_routing_rule {
    http_listener_name         = local.listener_name
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = 1
  }
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  lifecycle {
    ignore_changes = [
      tags,
      backend_address_pool,
      backend_http_settings,
      http_listener,
      probe,
      request_routing_rule,
      url_path_map,
    ]
  }
}
