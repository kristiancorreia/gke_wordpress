data "google_client_config" "default" {}

provider "kubernetes" {
  host = var.imported_cluster_endpoint

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.imported_cluster_ca_certificate)
}

resource "random_id" "cluster_suffix" {
  byte_length = 4
}

resource "kubernetes_secret" "cloud-sql-db-credentials" {
  metadata {
    name = "cloud-sql-db-credentials-${random_id.cluster_suffix.hex}"
  }

  data = {
    username = var.imported_username
    password = var.imported_password
  }
}