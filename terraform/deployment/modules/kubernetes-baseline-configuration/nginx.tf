resource "helm_release" "internal_nginx_ingress" {
  count      = var.enable_internal_nginx ? 1 : 0
  name       = "interal-nginx-ingress"
  namespace  = "internal-nginx-system"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  version    = "2.0.0" # Replace with the latest version if needed

  create_namespace = true

  values = [
    <<-EOF
    controller:
      ingressClass:
        name: interal-nginx-ingress
      service:
        annotations:
          service.beta.kubernetes.io/azure-load-balancer-internal: "true"
        type: LoadBalancer
    EOF
  ]
}

resource "helm_release" "nginx_ingress" {
  count      = var.enable_external_nginx ? 1 : 0
  name       = "nginx-ingress"
  namespace  = "nginx-system"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  version    = "2.0.0" # Replace with the latest version if needed

  create_namespace = true

  values = [
    <<-EOF
    controller:
      service:
        annotations:
          kubernetes.io/ingress.class: nginx
        type: LoadBalancer
    EOF
  ]
}
