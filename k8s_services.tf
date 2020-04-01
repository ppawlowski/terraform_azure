resource "kubernetes_secret" "wp_storage_secret" {
  metadata {
    name = "wp-storage-secret"
  }
  data = {
    azurestorageaccountkey  = var.azure_shared_storage_key
    azurestorageaccountname = azurerm_storage_account.storage.name
  }
  type = "Opaque"
}

resource "kubernetes_deployment" "wp" {
  metadata {
    name = "wp"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "wp"
      }
    }

    template {
      metadata {
        labels = {
          app = "wp"
        }
      }

      spec {
        volume {
          name = "wp-shared"

          azure_file {
            secret_name = kubernetes_secret.wp_storage_secret.metadata.0.name
            share_name  = azurerm_storage_share.storage_share.name
          }
        }

        container {
          name  = "wp"
          image = "nginxwp.azurecr.io/wp:latest"

          port {
            container_port = 80
          }

          volume_mount {
            name       = "wp-shared"
            mount_path = "/var/www/html/wp-content"
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
  lifecycle {
    ignore_changes = [spec.0.template.0.metadata.0.labels]
  }
}

resource "kubernetes_service" "wp_svc" {
  metadata {
    name = "wp-svc"
    labels = {
      app = "wp"
    }
  }

  spec {
    port {
      protocol = "TCP"
      port     = 80
    }
    selector = {
      app = "wp"
    }
  }
}