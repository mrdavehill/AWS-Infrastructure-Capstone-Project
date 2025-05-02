#######################################################
# kubernetes
#######################################################
output "this" {
  value = kubectl_manifest.namespaces
}

output "this" {
  value = kubectl_manifest.manifests
}