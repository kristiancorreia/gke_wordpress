output "pvc_name" {
  value = kubernetes_persistent_volume_claim.wordpress-volumeclaim.name
}