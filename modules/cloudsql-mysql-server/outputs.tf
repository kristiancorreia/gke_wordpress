output "sql_instance_username" {
  value = google_sql_user.wordpress.name
}

output "sql_instance_password" {
  value = google_sql_user.wordpress.password
  sensitive = true
}

output "sql_instance_connection_name" {
  value = google_sql_database_instance.kc-gke-wp-sql-server.connection_name
}