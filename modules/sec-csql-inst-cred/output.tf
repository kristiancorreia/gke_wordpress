output "sec_name" {
  value = kubernetes_secret.cloud-sql-instance-credentials.metadata[0].name
}