variable "resource_group_name" {
  description = "The Resource Group Name."
  type        = string
}

variable "flux_git_repository_metadata_name" {
  default     = "flux-repo"
  description = "The metadata name of the reference Flux will use."
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID."
  type        = string
}

variable "subscription_id" {
  description = "The Subscription ID."
  type        = string
}

variable "identity_client_id" {
  description = "The identity of Kubelet to be able to pull."
  type        = string
}

variable "domain_filter" {
  description = "The Domain Name External-DNS will filter for."
  type        = string
}

variable "enable_internal_nginx" {
  default     = false
  description = "Is internal Nginx Required."
  type        = bool
}

variable "enable_external_nginx" {
  default     = true
  description = "Is external Nginx Required."
  type        = bool
}
