############################################################
# Cluster AKS
############################################################
resource "azurerm_kubernetes_cluster" "aks" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = "aks-${var.all_tags["environment"]}"
  kubernetes_version      = var.kubernetes_version
  private_cluster_enabled = var.private_cluster

  default_node_pool {
    name           = format("aks${var.all_tags["environment"]}pool")
    node_count     = var.env_node_count
    max_pods       = var.env_aks_max_pod_number
    type           = var.node_pool_type
    vm_size        = var.vm_size
    vnet_subnet_id = var.vnet_subnet_id
    zones          = var.node_pool_zones
    # os_disk_type       = "Ephemeral"
    tags = var.all_tags
  }

  identity {
    type = var.identity_type
  }

  network_profile {
    load_balancer_sku = var.load_balancer_sku
    network_plugin    = var.network_plugin
  }

  tags = var.all_tags
}

############################################################
# Decided to use a docker image with MongoDB inside because of
# the constant problems with the ComsosDB establishment which is really a killer
# Message: Sorry, we are currently experiencing high demand in West Europe region, and cannot fulfill your request
# Really so many bugs still in Azure
############################################################
# resource "random_string" "kv" {
#   length  = 8
#   special = false
# }
# resource "azurerm_key_vault" "this" {
#   name                       = "kv-test-${random_string.kv.result}"
#   location                   = data.azurerm_resource_group.vnet_001.location
#   resource_group_name        = data.azurerm_resource_group.vnet_001.name
#   tenant_id                  = data.azurerm_client_config.current.tenant_id
#   soft_delete_retention_days = 10
#   purge_protection_enabled   = false
#   sku_name                   = "standard"
# }

# resource "azurerm_key_vault_access_policy" "user_assigned_identity" {
#   key_vault_id            = azurerm_key_vault.this.id
#   tenant_id               = data.azurerm_client_config.current.tenant_id
#   object_id               = azurerm_user_assigned_identity.this.principal_id
#   certificate_permissions = ["Get", "List"]
#   key_permissions         = ["Get", "List"]
#   secret_permissions      = ["Get", "List", "Set", "Delete"]
#   storage_permissions     = ["Get", "List"]
# }

# resource "azurerm_key_vault_access_policy" "this" {
#   key_vault_id       = azurerm_key_vault.this.id
#   tenant_id          = data.azurerm_client_config.current.tenant_id
#   object_id          = data.azurerm_client_config.current.object_id
#   secret_permissions = ["Get", "List", "Set", "Delete", "Purge"]
# }

# resource "azurerm_key_vault_secret" "cosmosdb_endpt" {
#   name         = "CosmosEndpoint"
#   value        = azurerm_cosmosdb_account.this.endpoint
#   key_vault_id = azurerm_key_vault.this.id
#   depends_on = [
#     azurerm_key_vault_access_policy.this
#   ]
# }

# resource "azurerm_user_assigned_identity" "example" {
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   name                = "example-resource"
# }

# resource "azurerm_cosmosdb_account" "this" {
#   name                = "tfex-cosmos-db-651231651-customid"
#   location            = data.azurerm_resource_group.vnet_001.location
#   resource_group_name = data.azurerm_resource_group.vnet_001.name
#   offer_type          = "Standard"
#   kind                = "MongoDB"

#   capabilities {
#     name = "EnableMongo"
#   }

#   consistency_policy {
#     consistency_level = "Session"
#   }

#   geo_location {
#     location          = data.azurerm_resource_group.vnet_001.location
#     failover_priority = 0
#   }
# }

# resource "azurerm_cosmosdb_mongo_database" "this" {
#   name                = "tfex-cosmos-db-651231651-customid"
#   resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
#   account_name        = azurerm_cosmosdb_account.this.name
#   throughput          = 400
# }
