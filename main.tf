module "gke-cluster" {
  source = "./modules/gke-cluster"
}

module "pvc" {
  source = "./modules/pvc"
  imported_cluster_endpoint = module.gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.gke-cluster.cluster_ca_certificate
}

module "cloud-sql-server" {
  source = "./modules/cloudsql-mysql-server"
}

module "service-account" {
  source = "./modules/service-account"
}

module "secret-cloud-sql-db-credentials" {
  source = "./modules/sec-csql-db-cred"
  imported_cluster_endpoint = module.gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.gke-cluster.cluster_ca_certificate
  imported_username = module.cloud-sql-server.sql_instance_username
  imported_password = module.cloud-sql-server.sql_instance_password
}

module "secret-cloud-sql-instance-credentials" {
  source = "./modules/sec-csql-inst-cred"
  imported_cluster_endpoint = module.gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.gke-cluster.cluster_ca_certificate
  imported_sa_key = module.service-account.service_account_key
}

module "wordpress-deployment" {
  source = "./modules/wordpress-deployment"
  imported_cluster_endpoint = module.gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.gke-cluster.cluster_ca_certificate
  imported_cloud_sql_name = module.cloud-sql-server.sql_instance_connection_name
}

module "wordpress-service" {
  source = "./modules/wordpress-service"
  imported_cluster_endpoint = module.gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.gke-cluster.cluster_ca_certificate
}