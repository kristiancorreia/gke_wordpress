variable "imported_cluster_endpoint" {
    type = string
}

variable "imported_cluster_ca_certificate" {
  type = string
}

variable "imported_cloud_sql_name" {
  type = string
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host = var.imported_cluster_endpoint

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.imported_cluster_ca_certificate)
}

resource "kubernetes_deployment" "wordpress-deployment" {
  metadata {
    name = "wordpress-deployment"
    labels = {
    app = "wodpress"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "wordpress"
      }
    }
    template {
      metadata {
        labels = {
          app = "wordpress"
        }
      }

      spec {
        container {
          image = "wordpress"
          name  = "wordpress"
          env {
              name = "WORDPRESS_DB_HOST"
              value "127.0.0.1:3306"
          }
          env {
              name "WORDPRESS_DB_USER"
              value_from {
                  secret_key_ref {
                    name = "cloud-sql-db-credentials"
                    key = "username"
                  }
              }
          }
          env {
              name "WORDPRESS_DB_PASSWORD"
              value_from {
                  secret_key_ref {
                    name = "cloud-sql-db-credentials"
                    key = "password"
                  }
              }
          }
          port {
            container_port = "80"
            name = "wordpress"
          }
          volume_mount {
            name = "wordpress-persistent-storage"
            mount_path = "/var/www/html"
          }
        }
        container {
          name = "cloudsql-proxy"
          image = "gcr.io/cloudsql-docker/gce-proxy:1.11"
          command = ["/cloud_sql_proxy",
                    "-instances=${var.imported_cloud_sql_name}=tcp:3306",
                    "-credential_file=/secrets/cloudsql/key.json"]
          security_context {
              run_as_user = "2"
              allow_privilege_escalation = "false"
          }
          volume_mount {
              name = "cloudsql-instance-credentials"
              mount_path = "/secrets/cloudsql"
              read_only "true"
          }

        }
        volume {
          name = "wordpress-persistent-storage"
          persistant_volume_claim {
            claim_name = "wordpress-volumeclaim"
          }
        }
        volume {
          name = "cloudsql-instance-credentials"
          secret {
            secret_name = "cloudsql-instance-credentials"
          }
        }
      }
    }
  }
}