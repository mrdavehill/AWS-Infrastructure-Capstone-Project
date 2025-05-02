data "kubectl_path_documents" "this" {
    pattern = "./manifests/${var.project}/*.yaml"
}