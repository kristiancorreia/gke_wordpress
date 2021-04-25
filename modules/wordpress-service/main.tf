data "google_client_config" "default" {}

provider "kubernetes" {
  host = var.imported_cluster_endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.imported_cluster_ca_certificate)
}

resource "kubernetes_service" "wordpress-service" {
  metadata {
    name  = "worpress-service"
    labels = {
      app = "wordpress"
    }
  }
  spec {
    type = "LoadBalancer"
    port {
      port = "80"
      target_port = "80"
      protocol = "TCP"
    }
    selector = {
      app = "wordpress"
    }
  }
}