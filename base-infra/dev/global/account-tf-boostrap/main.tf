# Backend for Terraform state file
resource "azurerm_resource_group" "terraformbackend" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_storage_account" "terraform_backend" {
  name                          = var.storage_account_name
  resource_group_name           = azurerm_resource_group.terraformbackend.name
  location                      = azurerm_resource_group.terraformbackend.location
  account_tier                  = var.storage_account_tier
  account_replication_type      = var.storage_account_replication_type
  public_network_access_enabled = true
}

resource "azurerm_storage_container" "terraform_backend" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.terraform_backend.name
  container_access_type = var.container_access_type
}
