#######################################################
# kubernetes
#######################################################
resource "kubectl_manifest" "this" {
    yaml_body = <<YAML
"${var.yaml}"
  YAML
}