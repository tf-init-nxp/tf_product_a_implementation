output "aks_ip_address" {
  value       = var.aks_enable == true ? data.azurerm_public_ip.aks_public_ip[0].ip_address : 0
  description = "AKS Cluster IP Address"
}

output "aks_client_certificate" {
  value       = var.aks_enable == true ? base64decode(module.create_aks[0].client_certificate) : 0
  description = "client_certificate"
  sensitive = true
}

output "aks_client_client_key" {
  value       = var.aks_enable == true ? base64decode(module.create_aks[0].client_key) : 0
  description = "client_key"
  sensitive = true
}

output "aks_cluster_ca_certificate" {
  value       = var.aks_enable == true ? base64decode(module.create_aks[0].cluster_ca_certificate) : 0
  description = "cluster_ca_certificate"
  sensitive = true
}