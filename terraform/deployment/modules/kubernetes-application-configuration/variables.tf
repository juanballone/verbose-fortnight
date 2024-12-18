variable "path" {
  default     = "./clusters/automatic-fortnight-cluster"
  description = "The path for Flux to monitor for changes in files."
  type        = string
}

variable "namespace" {
  default     = "microservice"
  description = "Kubernetes Namespace."
  type        = string
}

variable "identity_client_id" {
  description = "The identity of Kubelet to be able to pull."
  sensitive   = true
  type        = string
}

variable "flux_git_repository_url" {
  default     = "ssh://git@github.com/ORG/REPO"
  description = "The SSH URL for the git repository we want Flux to monitor for deployments."
  type        = string
}

variable "flux_git_repository_metadata_name" {
  default     = "application-repo"
  description = "The metadata name of the reference Flux will use."
  type        = string
}

variable "flux_git_ssh_private_key" {
  description = "The Repository Private Key for Flux to use on the AKS cluster for syncing repository manifests."
  sensitive   = true
  type        = string
}


variable "resource_group_name" {
  description = "The Resource Group Name."
  type        = string
}

variable "dns_hosted_zone_name" {
  description = "The Azure DNS Zone ."
  type        = string
}

variable "subscription_id" {
  description = "The Subscription ID."
  type        = string
}
