variable "name" {
  type        = string
  default     = "aks-test-cluster"
  description = "values for the name of the AKS cluster"
}

variable "resource_group_name" {
  type        = string
  default     = "aks-test-rg"
  description = "The name of the resource group where the AKS cluster will be created"
}

variable "vnet_subnet_id" {
  type        = string
  default     = "subnet-001"
  description = "The ID of the subnet where the AKS cluster will be deployed"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.32"
  description = "The version of Kubernetes to use for the AKS cluster"
}

variable "private_cluster" {
  type        = bool
  default     = false
  description = "Enable or disable private cluster for AKS"
}

variable "node_pool_type" {
  type        = string
  default     = "VirtualMachineScaleSets"
  description = "The type of node pool to use for the AKS cluster"
}

variable "vm_size" {
  type        = string
  default     = "Standard_A2m_v2"
  description = "The type of VM to use for the AKS nodes"
}

variable "node_pool_zones" {
  type        = list(string)
  default     = ["1"]
  description = "The availability zones for the AKS node pool"
}

variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "The type of identity to use for the AKS cluster"
}

variable "load_balancer_sku" {
  type        = string
  default     = "standard"
  description = "The SKU of the load balancer to use for the AKS cluster"
}

variable "network_plugin" {
  type        = string
  default     = "azure"
  description = "The network plugin to use for the AKS cluster"
}

variable "env_node_count" {
  type    = number
  default = 1
}

variable "env_aks_max_pod_number" {
  type    = number
  default = 30
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
  default     = "westeurope"
}

variable "all_tags" {
  type = map(any)
  default = {
    project     = "AKS-hub-spoke-setup"
    automate    = "terraform"
    environment = "dev"
  }
}
