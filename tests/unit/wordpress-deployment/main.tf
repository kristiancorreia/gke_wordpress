provider "google" {
  project = "kc-gke-wp"
}

module "test-gke-cluster" {
  source = "../../../modules/test-gke-cluster"
}

module "service-account" {
  source = "../../../modules/service-account"
}

module "pvc" {
  source = "../../../modules/pvc"
  imported_cluster_endpoint = module.test-gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.test-gke-cluster.cluster_ca_certificate
}

module "secret-cloud-sql-db-credentials" {
  source = "../../../modules/sec-csql-db-cred"
  imported_cluster_endpoint = module.test-gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.test-gke-cluster.cluster_ca_certificate
  imported_username = "foo"
  imported_password = "bar"
}

module "secret-cloud-sql-instance-credentials" {
  source = "../../../modules/sec-csql-inst-cred"
  imported_cluster_endpoint = module.test-gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.test-gke-cluster.cluster_ca_certificate
  imported_sa_key = module.service-account.service_account_key
}

module "wordpress-deployment" {
  source = "../../../modules/wordpress-deployment"
  imported_cluster_endpoint = module.test-gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.test-gke-cluster.cluster_ca_certificate
  imported_cloud_sql_name = "foo"
  imported_pvc_name = module.pvc.pvc_name
  imported_csql_inst_cred_sec_name = module.secret-cloud-sql-instance-credentials.sec_name
  imported_csql_db_cred_sec_name = module.secret-cloud-sql-db-credentials.sec_name
}

