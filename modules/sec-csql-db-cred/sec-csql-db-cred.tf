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

variable "imported_username" {
    type = string
}

variable "imported_password" {
    type = string
}

resource "kubernetes_secret" "cloud-sql-db-credentials" {
  metadata {
    name = "cloud-sql-db-credentials"
  }

  data = {
    username = var.imported_username
    password = var.imported_password
  }
}