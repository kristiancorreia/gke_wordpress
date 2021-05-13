provider "google" {
  project = "kc-gke-wp"
}

module "service-account" {
  source = "../../../modules/service-account"
}
