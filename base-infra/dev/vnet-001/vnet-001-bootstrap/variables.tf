variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created."
  type        = string
  default     = ""
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
  default     = "westeurope"
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = ""
}

variable "vnet_address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = [""]
}

variable "subnets" {
  description = "A map of subnets to create within the virtual network."
  type = map(object({
    name           = string
    address_prefix = string
  }))
  default = null
}

variable "all_tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default = {
    project     = "AKS-hub-spoke-setup"
    automate    = "terraform"
    environment = "dev"
  }
}
