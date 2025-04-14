output "vnet_id" {
  value       = module.vnet_001.vnet_id
  description = "The ID of the Virtual Network"
}

output "vnet_name" {
  value       = module.vnet_001.vnet_name
  description = "The name of the Virtual Network"
}

output "vnet_address_space" {
  value       = module.vnet_001.vnet_address_space
  description = "The address space of the Virtual Network"
}

output "subnet_ids" {
  value       = module.vnet_001.vnet_subnet_id
  description = "The IDs of the Subnets in the Virtual Network"
}
