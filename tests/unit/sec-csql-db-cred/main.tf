provider "google" {
  project = "kc-gke-wp"
}

module "test-gke-cluster" {
  source = "../../../modules/test-gke-cluster"
}

module "cloudsql-mysql-server" {
  source = "../../../modules/cloudsql-mysql-server"
}

module "sec-csql-db-cred" {
  source = "../../../modules/sec-csql-db-cred"
  imported_cluster_endpoint = module.test-gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.test-gke-cluster.cluster_ca_certificate
  imported_username = module.cloudsql-mysql-server.sql_instance_username
  imported_password = module.cloudsql-mysql-server.sql_instance_password
}