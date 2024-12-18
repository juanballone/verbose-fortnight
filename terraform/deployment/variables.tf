variable "remote_state_rg_name" {
  type        = string
  description = "The resource group name for the remote state backend"
}

variable "remote_state_storage_account" {
  type        = string
  description = "The storage account name for the remote state backend"
}

variable "remote_state_container" {
  type        = string
  description = "The container name for the remote state backend"
}

variable "remote_state_key" {
  type        = string
  description = "The key for the remote state file"
}
