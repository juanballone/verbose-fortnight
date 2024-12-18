output "resource_group_name" {
  description = "The Name of the Resource Group."
  value       = module.main.resource_group_name
}

output "virtual_network_id" {
  description = "The Resource ID of the Virtual Network."
  value       = module.main.virtual_network_id
}
