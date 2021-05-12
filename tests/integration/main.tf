provider "google" {
  project = "kc-gke-wp"
}

module "gke-cluster" {
  source = "../../"
}
