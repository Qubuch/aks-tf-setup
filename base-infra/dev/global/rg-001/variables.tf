
variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
  default     = "westeurope"
}

variable "all_tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default = {
    project     = "AKS-hub-spoke-setup"
    automate    = "terraform"
    environment = "dev"
  }
}
