data "azurerm_resource_group" "vnet_001" {
  name = "spoke-rg"
}

data "azurerm_subnet" "aks-subnet-001" {
  name                 = "subnet-001"
  virtual_network_name = "vnet-001"
  resource_group_name  = data.azurerm_resource_group.vnet_001.name
}

#################################################################
# Cluster AKS
#################################################################
module "aks" {
  source              = "../../../../az-modules/aks.module"
  resource_group_name = data.azurerm_resource_group.vnet_001.name
  vnet_subnet_id      = data.azurerm_subnet.aks-subnet-001.id
}
