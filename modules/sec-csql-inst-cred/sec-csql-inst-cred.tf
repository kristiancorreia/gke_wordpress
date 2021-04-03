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

variable "imported_sa_key" {
}

resource "kubernetes_secret" "cloud-sql-instance-credentials" {
  metadata {
    name = "cloud-sql-instance-credentials"
  }

  data = {
    "key.json" = var.imported_sa_key
  }
}