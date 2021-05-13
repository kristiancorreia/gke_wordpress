provider "google" {
  project = "kc-gke-wp"
}

module "test-gke-cluster" {
  source = "../../../modules/test-gke-cluster"
}

module "wordpress-service" {
  source = "../../../modules/wordpress-service"
  imported_cluster_endpoint = module.test-gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.test-gke-cluster.cluster_ca_certificate
}