module "gke-cluster" {
  source = "./modules/gke-cluster"
}

output "cluster_endpoint" {
  value = module.gke-cluster.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.gke-cluster.cluster_ca_certificate
}

module "pvc" {
  source = "./modules/pvc"
  imported_cluster_endpoint = module.gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.gke-cluster.cluster_ca_certificate
}