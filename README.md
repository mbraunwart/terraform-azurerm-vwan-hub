<!-- BEGIN_TF_DOCS -->
<!-- TOC -->
<!-- /TOC -->

# Azure Enterprise Virtual WAN Hub Module

This Terraform module provides an enterprise-ready framework for creating and managing Azure Virtual WAN Hubs. It simplifies the deployment of global network infrastructure, enabling secure and scalable connectivity across regions, branch offices, and cloud resources.

## Purpose

The module's primary goal is to streamline the provisioning of Azure Virtual WAN Hub resources while implementing enterprise-grade networking patterns. It reduces complexity in managing global network architectures and provides built-in monitoring and security capabilities.

## Key Capabilities

- **Office 365 Network Optimization**  
  Built-in support for Office 365 traffic categorization and optimization through local breakout configurations.

- **VPN Gateway Integration**  
  Optional VPN Gateway deployment with configurable scale units for branch connectivity.

- **Advanced Routing**  
  Custom route tables and next-hop configurations for precise traffic control.

### Architecture Overview

Virtual WAN Hubs serve as the centerpiece of your global network architecture, providing:
- Centralized connectivity management
- Regional traffic optimization
- Secure branch office connectivity
- Integration with Azure backbone for reliable global routing

### Best Practices

- Plan IP address spaces carefully to avoid overlaps across regions
- Use Standard SKU for production workloads requiring advanced features
- Enable monitoring and flow logs for network visibility
- Configure appropriate retention policies for diagnostic data
- Implement proper tagging for resource organization
- Use branch-to-branch traffic controls based on security requirements

## Known Limitations

- Basic SKU has limited feature availability compared to Standard
- VPN Gateway deployment requires Standard SKU
- Office 365 optimization requires proper category selection
- Resource quotas may limit scalability in some subscriptions

## Usage Example

```hcl
module "virtual_wan_hub" {
  source = "github.com/org/terraform-azurerm-virtual-hub"

  resource_group_name = "rg-vwan-prod"
  location            = "eastus2"

  wan_config = {
    name = "vwan-global"
    type = "Standard"
  }

  hub_config = {
    name                           = "hub-eastus2"
    address_space                  = "10.0.0.0/23"
    sku                           = "Standard"
    routing_preference            = "ExpressRoute"
    allow_branch_to_branch_traffic = true
    disable_vpn_encryption         = false
    office365_category            = "Optimize"
    routes = []
  }

  tags = {
    Environment = "Production"
    Department  = "Networking"
  }
}
```

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement_terraform) (>=1.5.0, <2.0.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) (>= 4.12.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) (>= 4.12.0)

## Resources

The following resources are used by this module:

- [azurerm_virtual_hub.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub) (resource)
- [azurerm_virtual_wan.wan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_wan) (resource)
- [azurerm_vpn_gateway.gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_gateway) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_hub_config"></a> [hub_config](#input_hub_config)

Description: Configuration for the Virtual Hub

Type:

```hcl
object({
    name                           = string
    address_space                  = string
    sku                            = string
    routing_preference             = optional(string, "ExpressRoute")
    allow_branch_to_branch_traffic = optional(bool)
    disable_vpn_encryption         = optional(bool)
    office365_category             = optional(string, "Optimize")
    routes = optional(list(object({
      address_prefixes    = list(string)
      next_hop_ip_address = string
    })), [])
  })
```

### <a name="input_location"></a> [location](#input_location)

Description: The Azure region where the Virtual WAN Hub resources will be deployed.

Type: `string`

### <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name)

Description: The name of the Resource Group hosting the Virtual WAN Hub.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_tags"></a> [tags](#input_tags)

Description: A mapping of tags for resource organization.

Type: `map(string)`

Default: `{}`

### <a name="input_vpn_config"></a> [vpn_config](#input_vpn_config)

Description: Configuration for VPN Gateway and Sites

Type:

```hcl
object({
    gateway = object({
      name       = string
      scale_unit = number
    })
    sites = optional(list(object({
      name          = string
      address_cidrs = list(string)
    })), [])
  })
```

Default:

```json
{
  "gateway": null,
  "sites": []
}
```

### <a name="input_wan_config"></a> [wan_config](#input_wan_config)

Description: Configuration for the Virtual WAN

Type:

```hcl
object({
    name = string
    type = string
  })
```

Default:

```json
{
  "name": null,
  "type": "Standard"
}
```

## Outputs

The following outputs are exported:

### <a name="output_hub_address_prefix"></a> [hub_address_prefix](#output_hub_address_prefix)

Description: The address prefix of the Virtual Hub.

### <a name="output_hub_routing_preference"></a> [hub_routing_preference](#output_hub_routing_preference)

Description: The routing preference of the Virtual Hub.

### <a name="output_virtual_hub_id"></a> [virtual_hub_id](#output_virtual_hub_id)

Description: The ID of the Virtual Hub resource.

### <a name="output_virtual_hub_name"></a> [virtual_hub_name](#output_virtual_hub_name)

Description: The name of the Virtual Hub resource.

### <a name="output_virtual_wan_id"></a> [virtual_wan_id](#output_virtual_wan_id)

Description: The ID of the Virtual WAN resource.

### <a name="output_virtual_wan_name"></a> [virtual_wan_name](#output_virtual_wan_name)

Description: The name of the Virtual WAN resource.

### <a name="output_virtual_wan_type"></a> [virtual_wan_type](#output_virtual_wan_type)

Description: The type of the Virtual WAN (Basic or Standard).

### <a name="output_vpn_gateway_bgp_settings"></a> [vpn_gateway_bgp_settings](#output_vpn_gateway_bgp_settings)

Description: The BGP settings of the VPN Gateway.

### <a name="output_vpn_gateway_id"></a> [vpn_gateway_id](#output_vpn_gateway_id)

Description: The ID of the VPN Gateway.

### <a name="output_vpn_gateway_name"></a> [vpn_gateway_name](#output_vpn_gateway_name)

Description: The name of the VPN Gateway.

### <a name="output_vpn_gateway_scale_unit"></a> [vpn_gateway_scale_unit](#output_vpn_gateway_scale_unit)

Description: The scale unit of the VPN Gateway.
<!-- END_TF_DOCS -->