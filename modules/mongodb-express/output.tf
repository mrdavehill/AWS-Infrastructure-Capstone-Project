#######################################################
# namespaces
#######################################################
output "db-namespace" {
  value = nonsensitive(kubectl_manifest.db-namespace)
}

output "web-namespace" {
  value = nonsensitive(kubectl_manifest.web-namespace)
}

#######################################################
# configmap
#######################################################
output "mongodb-configmap" {
  value = nonsensitive(kubectl_manifest.mongodb-configmap)
}
#######################################################
# deployments
#######################################################
output "mongo-express-deployment" {
  value = nonsensitive(kubectl_manifest.mongo-express-deployment)
}

output "mongodb-deployment" {
  value = nonsensitive(kubectl_manifest.mmongodb-deployment)
}

#######################################################
# services
#######################################################
output "mongodb-express-service" {
  value = nonsensitive(kubectl_manifest.mongodb-express-service)
}

output "mongodb-service" {
  value = nonsensitive(kubectl_manifest.mongodb-service)
}