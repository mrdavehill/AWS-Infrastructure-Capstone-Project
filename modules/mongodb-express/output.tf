#######################################################
# namespaces
#######################################################
output "db-namespace" {
  value = kubectl_manifest.db-namespace
}

output "web-namespace" {
  value = kubectl_manifest.web-namespace
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
  value = kubectl_manifest.mmongodb-deployment
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