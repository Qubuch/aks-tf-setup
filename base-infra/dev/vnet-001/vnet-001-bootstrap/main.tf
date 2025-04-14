data "azurerm_resource_group" "vnet_001" {
  name = "spoke-rg"
}

# Coming from AWS its a bit confusing not having public and private subnets (then need to create a NAT gateway to access the internet from private subnets)
# Internet Outbound traffic in an Azure subnet:
# Currently, a resource deployed in an Azure subnet gets automatically a default route to access internet. 
# That only allows outbound traffic. You can change that default behavior with different options. 
# This default behavior will be removed in September 2025.
# See article: https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/default-outbound-access
module "vnet_001" {
  source                        = "../../../../az-modules/vnet.module"
  virtual_network_name          = "vnet-001"
  resource_group_name           = data.azurerm_resource_group.vnet_001.name
  location                      = data.azurerm_resource_group.vnet_001.location
  virtual_network_address_space = ["10.30.0.0/16"] # really strange bug in Azure that not allows AKS deployment https://github.com/Azure/terraform-azurerm-aks/issues/57#issuecomment-836261387
  subnets = [
    {
      name : "subnet-001"
      address_prefixes : ["10.30.0.0/24"]
    },
    {
      name : "subnet-002"
      address_prefixes : ["10.30.1.0/24"]
    }
  ]
  all_tags = var.all_tags
}
