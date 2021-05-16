resource "random_id" "cluster_suffix" {
  byte_length = 4
}

resource "google_container_cluster" "kc-gke-wp-gke-cluster" {
  name     = "kc-gke-wp-gke-cluster-${random_id.cluster_suffix.hex}"
  location = "northamerica-northeast1-c"

  remove_default_node_pool = true
  initial_node_count       = 1

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

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "primary-node-pool"
  location   = "northamerica-northeast1-c"
  cluster    = google_container_cluster.kc-gke-wp-gke-cluster.name
  node_count = 3
  management {
    auto_upgrade = true
    auto_repair = true
  }
  
    
  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}