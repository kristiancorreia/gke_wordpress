resource "google_container_cluster" "kc-gke-wp-gke-cluster" {
  name     = "kc-gke-wp-gke-cluster"
  location = "northamerica-northeast1-c"

  remove_default_node_pool = false
  initial_node_count       = 1
  node_config {
    preemptible  = true
    machine_type = "e2-micro"
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  master_auth {
    username = ""
    password = ""
    client_certificate_config {
        issue_client_certificate = false
    }
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block = "/16"
    services_ipv4_cidr_block = "/22"
  }
}