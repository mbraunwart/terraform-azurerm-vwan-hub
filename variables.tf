# Core Infrastructure Variables
variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group hosting the Virtual WAN Hub."
}

variable "location" {
  type        = string
  description = "The Azure region where the Virtual WAN Hub resources will be deployed."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags for resource organization."
  default     = {}
}

# Virtual WAN Configuration
variable "wan_config" {
  type = object({
    name = string
    type = string
  })
  description = "Configuration for the Virtual WAN"
  default = {
    name = null
    type = "Standard"
  }

  validation {
    condition     = contains(["Basic", "Standard"], var.wan_config.type)
    error_message = "The wan_type must be either 'Basic' or 'Standard'."
  }
}

# Hub Configuration
variable "hub_config" {
  type = object({
    name                           = string
    address_space                  = string
    sku                            = string
    routing_preference             = optional(string, "ExpressRoute")
    allow_branch_to_branch_traffic = bool
    disable_vpn_encryption         = bool
    office365_category             = optional(string, "Optimize")
    routes = list(object({
      address_prefixes    = list(string)
      next_hop_ip_address = string
    }))
  })
  description = "Configuration for the Virtual Hub"

  validation {
    condition     = contains(["Basic", "Standard"], var.hub_config.sku)
    error_message = "The hub_sku must be either 'Basic' or 'Standard'."
  }
  validation {
    condition     = contains(local.hub_routing_preferences, var.hub_config.routing_preference)
    error_message = format("The routing_preference must be either %s", join(", ", local.hub_routing_preferences))
  }
  validation {
    condition     = contains(local.breakout_categories, var.hub_config.office365_category)
    error_message = format("The office365_category must be one of: %s", join(", ", local.breakout_categories))
  }
}

# VPN Configuration
variable "vpn_config" {
  type = object({
    gateway = object({
      name       = string
      scale_unit = number
    })
    sites = list(object({
      name          = string
      address_cidrs = list(string)
    }))
  })
  description = "Configuration for VPN Gateway and Sites"
  default = {
    gateway = null
    sites   = []
  }
}
