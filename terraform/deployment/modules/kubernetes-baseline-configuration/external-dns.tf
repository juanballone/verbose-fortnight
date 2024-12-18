resource "kubernetes_service_account" "external_dns" {
  metadata {
    name      = "external-dns"
    namespace = "kube-system"
  }
}

resource "kubernetes_secret" "azure_config_file" {
  metadata {
    name      = "azure-config-file"
    namespace = "kube-system"
  }

  data = {
    "azure.json" = <<-EOF
    {
        "tenantId": "${var.tenant_id}",
        "subscriptionId": "${var.subscription_id}",
        "resourceGroup": "${var.resource_group_name}",
        "useManagedIdentityExtension": true,
        "userAssignedIdentityID": "${var.identity_client_id}"
    }
    EOF
  }
}

resource "kubernetes_cluster_role" "external_dns" {
  metadata {
    name = "external-dns"
  }

  rule {
    api_groups = [""]
    resources  = ["services", "endpoints", "pods"]
    verbs      = ["get", "watch", "list"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "watch", "list"]
  }

  rule {
    api_groups = [""]
    resources  = ["nodes"]
    verbs      = ["list"]
  }

  rule {
    api_groups = ["externaldns.k8s.io"]
    resources  = ["dnsrecords"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "external_dns" {
  metadata {
    name = "external-dns-viewer"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.external_dns.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.external_dns.metadata[0].name
    namespace = "kube-system"
  }
}

# Deployment for External-DNS
resource "kubernetes_deployment" "external_dns" {
  metadata {
    name      = "external-dns"
    namespace = "kube-system"
    labels = {
      app = "external-dns"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "external-dns"
      }
    }

    template {
      metadata {
        labels = {
          app = "external-dns"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.external_dns.metadata[0].name

        # Define volumes
        volume {
          name = "azure-config-volume"
          secret {
            secret_name = kubernetes_secret.azure_config_file.metadata[0].name
          }
        }

        container {
          name  = "external-dns"
          image = "k8s.gcr.io/external-dns/external-dns:v0.15.0"

          args = [
            "--provider=azure",
            "--azure-resource-group=${var.resource_group_name}",
            "--azure-subscription-id=${var.subscription_id}",
            "--domain-filter=${var.domain_filter}",
            "--registry=txt",
            "--txt-owner-id=external-dns",
            "--policy=upsert-only",
            "--source=ingress",
            "--source=service",
            "--log-level=info"
          ]

          # Mount the Secret as a volume in the container
          volume_mount {
            name       = "azure-config-volume"
            mount_path = "/etc/kubernetes"
            read_only  = true
          }
        }
      }
    }
  }
}
