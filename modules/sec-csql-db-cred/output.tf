output "sec_name" {
  value = kubernetes_secret.cloud-sql-db-credentials.metadata[0].name
}