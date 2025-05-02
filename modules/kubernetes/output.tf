#######################################################
# kubernetes
#######################################################
output "namespaces" {
  value = kubectl_manifest.namespaces
}

output "manifests" {
  value = kubectl_manifest.manifests
}