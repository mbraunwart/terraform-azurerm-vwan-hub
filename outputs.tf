output "virtual_hub_id" {
  description = "The ID of the Virtual Hub resource."
  value       = azurerm_virtual_hub.hub.id
}

output "virtual_hub_name" {
  description = "The name of the Virtual Hub resource."
  value       = azurerm_virtual_hub.hub.name
}

output "virtual_wan_id" {
  description = "The ID of the Virtual WAN resource."
  value       = azurerm_virtual_wan.wan.id
}

output "vpn_gateway_name" {
  description = "The name of the VPN Gateway."
  value       = azurerm_vpn_gateway.gw.0.name
}

output "vpn_gateway_id" {
  description = "The ID of the VPN Gateway."
  value       = azurerm_vpn_gateway.gw.0.id
}

output "virtual_wan_name" {
  description = "The name of the Virtual WAN resource."
  value       = azurerm_virtual_wan.wan.name
}

output "virtual_wan_type" {
  description = "The type of the Virtual WAN (Basic or Standard)."
  value       = azurerm_virtual_wan.wan.type
}

output "hub_address_prefix" {
  description = "The address prefix of the Virtual Hub."
  value       = azurerm_virtual_hub.hub.address_prefix
}

output "hub_routing_preference" {
  description = "The routing preference of the Virtual Hub."
  value       = azurerm_virtual_hub.hub.hub_routing_preference
}

output "vpn_gateway_bgp_settings" {
  description = "The BGP settings of the VPN Gateway."
  value       = try(azurerm_vpn_gateway.gw.0.bgp_settings, null)
}

output "vpn_gateway_scale_unit" {
  description = "The scale unit of the VPN Gateway."
  value       = try(azurerm_vpn_gateway.gw.0.scale_unit, null)
}
