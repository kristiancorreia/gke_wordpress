variable "imported_cluster_endpoint" {
    type = string
}

variable "imported_cluster_ca_certificate" {
  type = string
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host = var.imported_cluster_endpoint

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.imported_cluster_ca_certificate)
}

resource "kubernetes_persistent_volume_claim" "wordpress-volumeclaim" {
  metadata {
    name = "wordpress-volumeclaim"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "200Gi"
      }
    }
  }
}