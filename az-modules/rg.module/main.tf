###########################################
# Resource Group
###########################################
resource "azurerm_resource_group" "az-rg" {
  name     = var.az_rg_name
  location = var.az_rg_location

  tags = merge(var.all_tags)
}
