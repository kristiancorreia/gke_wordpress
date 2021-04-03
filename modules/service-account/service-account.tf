 resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_service_account" "kc-gke-wp-sa" {
  account_id   = "wp-service-account-id-${random_id.db_name_suffix.hex}"
  display_name = "WP-Service Account"
}

resource "google_project_iam_binding" "cloudsql-sa-cloudsql-admin-role" {
    role    = "roles/cloudsql.client"
     members = [
         "serviceAccount:${google_service_account.kc-gke-wp-sa.email}"
     ]
 }

resource "google_service_account_key" "kc-gke-wp-sa-key" {
  service_account_id = google_service_account.kc-gke-wp-sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}


output "service_account_key" {
  value = google_service_account_key.kc-gke-wp-sa-key.private_key
  sensitive = true
}
