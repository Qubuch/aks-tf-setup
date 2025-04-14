# Resource Group for Hub Global as its a global resource
module "hub-rg" {
  source         = "../../../../az-modules/rg.module"
  az_rg_name     = "spoke-rg"
  az_rg_location = var.location
  all_tags       = var.all_tags
}
