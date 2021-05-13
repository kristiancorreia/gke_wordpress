provider "google" {
  project = "kc-gke-wp"
}

module "full_build" {
  source = "../../"
}
