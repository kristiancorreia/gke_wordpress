provider "google" {
  project = "kc-gke-wp"
}

module "test-gke-cluster" {
  source = "../../../modules/test-gke-cluster"
}
