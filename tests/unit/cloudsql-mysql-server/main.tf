provider "google" {
  project = "kc-gke-wp"
}

module "cloudsql-mysql-server"" {
  source = "../../../modules/cloudsql-mysql-server"
}
