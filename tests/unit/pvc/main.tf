provider "google" {
  project = "kc-gke-wp"
}

module "test-gke-cluster" {
  source = "../../../modules/test-gke-cluster"
}

module "pvc" {
  source = "../../../modules/pvc"
  imported_cluster_endpoint = module.test-gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.test-gke-cluster.cluster_ca_certificate
}