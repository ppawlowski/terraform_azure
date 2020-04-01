resource "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx"
    namespace = "ingress-nginx"
    labels = {
      "app.kubernetes.io/name" = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }

  spec {
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 80
      target_port = "http"
    }
    port {
      name        = "https"
      protocol    = "TCP"
      port        = 443
      target_port = "https"
    }

    selector = {
      "app.kubernetes.io/name" = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }

    type                    = "LoadBalancer"
    external_traffic_policy = "Local"
  }
}

resource "kubernetes_ingress" "routing_for_wp" {
  metadata {
    name = "routing-for-wp"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    tls {
      hosts       = [var.wp_domain]
      secret_name = "tls-secret-prd"
    }
    rule {
      host = var.wp_domain
      http {
        path {
          path = "/"
          backend {
            service_name = "wp-svc"
            service_port = "80"
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress" "routing_for_wp_admin" {
  metadata {
    name = "routing-for-wp-admin"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
      "kubernetes.io/ingress.class" = "nginx"
      "nginx.ingress.kubernetes.io/limit-rps" = "2"
    }
  }
  spec {
    tls {
      hosts       = [var.wp_domain]
      secret_name = "tls-secret-prd"
    }
    rule {
      host = var.wp_domain
      http {
        path {
          path = "/wp-admin"
          backend {
            service_name = "wp-svc"
            service_port = "80"
          }
        }
      }
    }
    rule {
      host = var.wp_domain
      http {
        path {
          path = "/wp-login.php"
          backend {
            service_name = "wp-svc"
            service_port = "80"
          }
        }
      }
    }
  }
}