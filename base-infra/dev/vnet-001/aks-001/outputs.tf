output "aks_name" {
  value       = module.aks.aks_name
  description = "The name of the AKS cluster"
}

output "aks_fqdn" {
  value       = module.aks.aks_fqdn
  description = "The FQDN of the AKS cluster"
}

output "aks_kube_config" {
  value       = module.aks.aks_kube_config
  description = "The raw kubeconfig of the AKS cluster"
  sensitive   = true
}

output "aks_node_resource_group" {
  value       = module.aks.aks_node_resource_group
  description = "The resource group where AKS nodes are created"
}
