#######################################################
# kubernetes - create ns first
#######################################################
resource "kubectl_manifest" "namespace" {
  for_each  = var.namespace
  yaml_body = <<YAML
kind: Namespace
apiVersion: v1
metadata:
  name: "${var.namespace}"
YAML
}

#######################################################
# kubernetes - load manifests
#######################################################
resource "kubectl_manifest" "manifests" {
    depends_on = [kubectl_manifest.namespace]
    for_each   = toset(data.kubectl_path_documents.this.documents)
    yaml_body  = each.value
}