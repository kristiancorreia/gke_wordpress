module "gke-cluster" {
  source = "./modules/gke-cluster"
}

module "pvc" {
  source = "./modules/pvc"
  imported_cluster_endpoint = module.gke-cluster.cluster_endpoint
  imported_cluster_ca_certificate = module.gke-cluster.cluster_ca_certificate
}

module "cloud-sql-server" {
  source = "./modules/cloudsql-mysql-server"
}

module "service-account" {
  source = "./modules/service-account"
}

