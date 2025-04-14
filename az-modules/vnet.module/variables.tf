variable "virtual_network_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "virtual_network_address_space" {
  description = "name of the virtual network"
}

variable "subnets" {
  description = "Subnets configuration"
  type = list(object({
    name             = string
    address_prefixes = list(string)
    })
  )
}

variable "all_tags" {
  type    = map(string)
  default = {}
}
