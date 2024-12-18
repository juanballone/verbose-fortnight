output "cert_manager" {
  value = helm_release.cert_manager
}

output "nginx_ingress" {
  value = var.enable_external_nginx ? helm_release.nginx_ingress : null
}

output "internal_nginx_ingress" {
  value = var.enable_internal_nginx ? helm_release.nginx_ingress : null
}

output "flux" {
  value = helm_release.flux
}
