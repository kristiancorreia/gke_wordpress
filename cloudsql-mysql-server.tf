 
resource "google_sql_database_instance" "master" {
  name             = "kc-gke-wp-sql-server"
  database_version = "MYSQL_5_7"
  region           = "northamerica-northeast1"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
}
