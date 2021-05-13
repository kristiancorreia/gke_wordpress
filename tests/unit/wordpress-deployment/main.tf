provider "google" {
  project = "kc-gke-wp"
}

module "test-gke-cluster" {
  source = "../../../modules/test-gke-cluster"
}

module "cloudsql-mysql-server" {
  source = "../../../modules/cloudsql-mysql-server"
}

module "wordpress-deployment" {
  source = "../../../modules/wordpress-deployment"
  imported_cluster_endpoint = module.test-gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.test-gke-cluster.cluster_ca_certificate
  imported_cloud_sql_name = module.cloud-sql-server.sql_instance_connection_name
}