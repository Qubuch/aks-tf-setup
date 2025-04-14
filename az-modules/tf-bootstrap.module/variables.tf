variable "rg_name" {
  type    = string
  default = "tfstate"
}

variable "rg_location" {
  type    = string
  default = "switzerlandnorth"
}

variable "storage_account_name" {
  type    = string
  default = "tfstate65412132435724354"
}

variable "storage_account_tier" {
  type    = string
  default = "Standard"
}

variable "storage_account_replication_type" {
  type    = string
  default = "LRS"
}

variable "storage_container_name" {
  type    = string
  default = "terraformbackend"
}

variable "container_access_type" {
  type    = string
  default = "blob"
}

variable "all_tags" {
  type = map(any)
  default = {
    Project     = "AKS-hub-spoke-setup"
    Automate    = "terraform"
    Environment = "hub"
  }
}
