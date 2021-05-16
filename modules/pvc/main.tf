data "google_client_config" "default" {}

provider "kubernetes" {
  host = var.imported_cluster_endpoint

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.imported_cluster_ca_certificate)
}

resource "random_id" "cluster_suffix" {
  byte_length = 4
}

resource "kubernetes_persistent_volume_claim" "wordpress-volumeclaim" {
  metadata {
    name = "wordpress-volumeclaim-${random_id.cluster_suffix.hex}"
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