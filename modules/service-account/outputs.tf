output "service_account_key" {
  value = google_service_account_key.kc-gke-wp-sa-key.private_key
  sensitive = true
}