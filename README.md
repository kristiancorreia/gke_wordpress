# gke_wordpress
WordPress Project on GKE

Project is designed to deploy and manage a wordpress website using GKE and Cloud SQL. Project is provisions using Terraform and deploys using Cloud Build. The guide for constructing this build can be found here: https://cloud.google.com/kubernetes-engine/docs/tutorials/persistent-disk

Terraform state is stored in a GCS backend. To configure. Set bucket variable on line 3 of backend.tf file to desired bucket. In addition set the project variable in the home terraform script and in the teffaform test scripts to the desired GCP project.

Five pipelines are configured in the cloudbuild directory.

One of these is to provision the resources. It can be found in the construct subdirectory which will run terraform init followed by terraform apply -auto-approve.

The other is to teardown the project if desired. It can be found in the destroy subdirectory and runs terraform init followed by terraform destroy -auto-approve. To complete the construct of these pipelines, create Cloud Build Triggers that point to these files.

The remaining three pipelines are for orchestrating different types of test on the code using the Golang package Terratest. The pipeline in unit_test will take in a parameter for a specific module and will run a unit test on it. The pipeline cycle_unit_test wwill run unit tests for all modules in series. Lastly the pipeline integration_test will run a full test on the primary terraform script in the home directory.

A directory names tests contains all of the go and terraform scripts that execute the relevant tests.