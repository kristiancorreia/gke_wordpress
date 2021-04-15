terraform {
  backend "gcs" {
    bucket = "kc-gke-wp-13579"
    prefix = "state"
  }
}
