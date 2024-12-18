resource "helm_release" "flux" {
  name             = "flux"
  namespace        = "flux-system"
  chart            = "flux2"
  repository       = "https://fluxcd-community.github.io/helm-charts"
  version          = "2.14.0"
  create_namespace = true

  wait    = true
  timeout = 600
}
