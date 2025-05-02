#######################################################
# kubernetes - create ns first
#######################################################
resource "kubectl_manifest" "namespaces" {
  for_each  = toset(var.namespaces)
  yaml_body = <<YAML
kind: Namespace
apiVersion: v1
metadata:
  name: "${each.value}"
YAML
}

#######################################################
# kubernetes - load manifests
#######################################################
resource "kubectl_manifest" "manifests" {
    depends_on = [kubectl_manifest.namespaces]
    for_each   = toset(data.kubectl_path_documents.this.documents)
    yaml_body  = each.value
}