resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_manifest" "flux_kustomization" {
  manifest = {
    "apiVersion" = "kustomize.toolkit.fluxcd.io/v1beta2"
    "kind"       = "Kustomization"
    "metadata" = {
      "name"      = "flux-kustomization"
      "namespace" = "flux-system"
    }
    "spec" = {
      "interval" = "1m"
      "path"     = "${var.path}" # Path inside the repository
      "prune"    = true          # Remove resources not in the repo
      "sourceRef" = {
        "kind" = "GitRepository"
        "name" = var.flux_git_repository_metadata_name
      }
      "targetNamespace" = "${kubernetes_namespace.this.metadata[0].name}" # Namespace to apply resources
    }
  }
}

resource "kubernetes_service_account" "this" {
  metadata {
    name      = "microservice-sa"
    namespace = kubernetes_namespace.this.metadata[0].name
    annotations = {
      "azure.workload.identity/client-id" = "${var.identity_client_id}"
    }
  }
}

resource "kubernetes_manifest" "flux_git_repository" {
  manifest = {
    "apiVersion" = "source.toolkit.fluxcd.io/v1beta2"
    "kind"       = "GitRepository"
    "metadata" = {
      "name"      = "${var.flux_git_repository_metadata_name}"
      "namespace" = "flux-system"
    }
    "spec" = {
      "interval" = "1m"
      "url"      = var.flux_git_repository_url
      "ref" = {
        "branch" = "main"
      }
      "secretRef" = {
        "name" = "${kubernetes_secret.flux_git_ssh.metadata[0].name}"
      }
    }
  }
}

resource "kubernetes_secret" "flux_git_ssh" {
  metadata {
    name      = "flux-git-ssh"
    namespace = "flux-system"
  }

  data = {
    identity    = var.flux_git_ssh_private_key
    known_hosts = file("${path.module}/files/known_hosts")
  }

  type = "Opaque"
}


resource "kubernetes_manifest" "letsencrypt_staging_issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt-staging"
    }
    "spec" = {
      "acme" = {
        "server" = "https://acme-staging-v02.api.letsencrypt.org/directory"
        "email"  = "admin@dev.argentoriver.com"
        "privateKeySecretRef" = {
          "name" = "letsencrypt-staging"
        }
        "solvers" = [
          {
            "dns01" = {
              "azureDNS" = {
                "hostedZoneName"    = "${var.dns_hosted_zone_name}" # Your Azure DNS Zone
                "resourceGroupName" = "${var.resource_group_name}"
                "subscriptionID"    = "${var.subscription_id}"
                "environment"       = "AzurePublicCloud"
                "managedIdentity" = {
                  "clientID" = "${var.identity_client_id}"
                }
              }
            }
          }
        ]
      }
    }
  }
}

resource "kubernetes_manifest" "letsencrypt_prod_issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt-prod"
    }
    "spec" = {
      "acme" = {
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "email"  = "admin@dev.argentoriver.com"
        "privateKeySecretRef" = {
          "name" = "letsencrypt-prod"
        }
        "solvers" = [
          {
            "dns01" = {
              "azureDNS" = {
                "hostedZoneName"    = "${var.dns_hosted_zone_name}" # Your Azure DNS Zone
                "resourceGroupName" = "${var.resource_group_name}"
                "subscriptionID"    = "${var.subscription_id}"
                "environment"       = "AzurePublicCloud"
                "managedIdentity" = {
                  "clientID" = "${var.identity_client_id}"
                }
              }
            }
          }
        ]
      }
    }
  }
}
