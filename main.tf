resource "azurerm_virtual_wan" "wan" {
  name                              = var.wan_config.name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  type                              = var.wan_config.type
  allow_branch_to_branch_traffic    = var.hub_config.allow_branch_to_branch_traffic
  office365_local_breakout_category = var.hub_config.office365_category
  tags                              = var.tags
}

resource "azurerm_virtual_hub" "hub" {
  name                   = var.hub_config.name
  resource_group_name    = var.resource_group_name
  location               = var.location
  virtual_wan_id         = azurerm_virtual_wan.wan.id
  address_prefix         = var.hub_config.address_space
  hub_routing_preference = var.hub_config.routing_preference
  tags                   = var.tags

  dynamic "route" {
    for_each = var.hub_config.routes
    content {
      address_prefixes    = route.value.address_prefixes
      next_hop_ip_address = route.value.next_hop_ip_address
    }
  }
}

resource "azurerm_vpn_gateway" "gw" {
  count               = var.vpn_config.gateway != null ? 1 : 0
  name                = var.vpn_config.gateway.name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_hub_id      = azurerm_virtual_hub.hub.id
  scale_unit          = var.vpn_config.gateway.scale_unit
  tags                = var.tags
}
