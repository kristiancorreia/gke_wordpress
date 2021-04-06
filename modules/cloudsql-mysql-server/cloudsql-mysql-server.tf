 resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}
 
 resource "google_sql_database_instance" "kc-gke-wp-sql-server" {
  name             = "kc-gke-wp-sql-server-${random_id.db_name_suffix.hex}"
  database_version = "MYSQL_5_7"
  region           = "northamerica-northeast1"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
  deletion_protection = "false"
}



resource "google_sql_user" "wordpress" {
  name     = "wordpress"
  instance = google_sql_database_instance.kc-gke-wp-sql-server.name
  host = "%"
  password = random_password.password.result
}

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