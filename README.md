# gke_wordpress
WordPress Project on GKE

Project is designed to deploy and manage a wordpress website using GKE and Cloud SQL. Project is provisions using Terraform and deploys using Cloud Build.

Terraform state is stored in a GCS backend. To configure. Set bucket variable on line 3 of backend.tf file to desired bucket.

Two pipelines are configured in the cloudbuild directory. One of these is to provision the resources. It can be found in the construct subdirectory which will run terraform init followed by terraform apply -auto-approve. The other is to teardown the project if desired. It can be found in the destroy subdirectory and runs terraform init followed by terraform destroy -auto-approve. To complete the construct of these pipelines, create Cloud Build Triggers that point to these files.