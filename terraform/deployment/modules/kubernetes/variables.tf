variable "container_registry_id" {
  description = "The Resource ID of the container Registry."
  type        = string
}

variable "tags" {
  default = {
    environment = "dev",
    purpose     = "test"
  }
  description = "A map of tags."
  type        = map(string)
}

variable "enable_bastion" {
  default     = false
  description = "Is an Azure Bastion required."
  type        = bool
}

variable "enable_vm" {
  default     = false
  description = "Is an Virtual Machine required."
  type        = bool
}

variable "enable_azure_monitoring" {
  default     = false
  description = "Is Azure monitoring for the Azure Kubernetes Service Cluster required."
  type        = bool
}

variable "runners_resource_group_name" {
  description = "The Resource Group Name for the Runners."
  type        = string
}

variable "runners_virtual_network_id" {
  description = "The Resource ID of the Virtual Network for the Runners."
  type        = string
}

variable "runners_virtual_network_name" {
  description = "The Name of the Virtual Network for the Runners."
  type        = string
}

variable "aks_private_dns_zone_id" {
  description = "The Resource ID of the Private DNS Zone for Azure Kubernetes Service."
  type        = string
}

variable "aks_private_dns_zone_name" {
  description = "The Name of the Private DNS Zone for Azure Kubernetes Service. This is for Kube API."
  type        = string
}

variable "environment_public_dns_zone_id" {
  description = "The Resource ID of the DNS Zone for the environment. This is for the hosting of application endpoints."
  type        = string
}

variable "ampls_private_dns_zone_ids" {
  default     = []
  description = "A list of Resource IDs of the Private DNS Zone for AMPLS."
  type        = list(string)
}
