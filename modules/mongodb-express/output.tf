#######################################################
# namespaces
#######################################################
output "mongo-namespace" {
  value = kubectl_manifest.mongo-namespace
}

#######################################################
# configmap
#######################################################
output "mongodb-configmap" {
  value = kubectl_manifest.mongodb-configmap
}
#######################################################
# deployments
#######################################################
output "mongo-express-deployment" {
  value = kubectl_manifest.mongo-express-deployment
}

output "mongodb-deployment" {
  value = kubectl_manifest.mongodb-deployment
}

#######################################################
# services
#######################################################
output "mongodb-express-service" {
  value = kubectl_manifest.mongodb-express-service
}

output "mongodb-service" {
  value = kubectl_manifest.mongodb-service
}

#######################################################
# ingress
#######################################################
output "mongodb-ingressclass" {
    value = kubectl_manifest.mongodb-ingressclass
}

output "mongodb-ingress" {
    value = kubectl_manifest.mongodb-ingress
}

output "mongodb-ingress-dns-name" {
    value = data.aws_lb.this.dns_name
}