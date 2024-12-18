resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager" # Deploy into its own namespace
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.16.2" # Use the latest stable version of cert-manager

  create_namespace = true

  values = [
    <<-EOF
    installCRDs: true
    EOF
  ]

  wait    = true
  timeout = 600
}
