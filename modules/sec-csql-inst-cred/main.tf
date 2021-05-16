data "google_client_config" "default" {}

provider "kubernetes" {
  host = var.imported_cluster_endpoint

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.imported_cluster_ca_certificate)
}

resource "random_id" "cluster_suffix" {
  byte_length = 4
}

resource "kubernetes_secret" "cloud-sql-instance-credentials" {
  metadata {
    name = "cloud-sql-instance-credentials-${random_id.cluster_suffix.hex}"
  }

  data = {
    "key.json" = "${base64decode(var.imported_sa_key)}"
  }
}