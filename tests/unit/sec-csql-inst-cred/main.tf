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