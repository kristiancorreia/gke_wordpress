provider "google" {
  project = "kc-gke-wp"
}

module "test-gke-cluster" {
  source = "../../../modules/test-gke-cluster"
}

module "service-account" {
  source = "../../../modules/service-account"
}

module "sec-csql-inst-cred" {
  source = "../../../modules/sec-csql-inst-cred"
  imported_cluster_endpoint = module.test-gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.test-gke-cluster.cluster_ca_certificate
  imported_sa_key = module.service-account.service_account_key
}

module "cloudsql-mysql-server" {
  source = "../../../modules/cloudsql-mysql-server"
}

module "wordpress-deployment" {
  source = "../../../modules/wordpress-deployment"
  imported_cluster_endpoint = module.test-gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.test-gke-cluster.cluster_ca_certificate
  imported_cloud_sql_name = module.cloudsql-mysql-server.sql_instance_connection_name
}