#######################################################
# provider
#######################################################
variable "region" {
  type        = string
  description = "The region the provider will be configured for"
}

#######################################################
# vpc
#######################################################
variable "cidr" {
  type        = string
  description = "RFC1918 CIDR block for the VPC"
}

#######################################################
# kubernetes
#######################################################
variable "kubernetes" {
  type        = object({
    project   = optional(string)
    namespace = list(string)
  })
  description = "Variables needed to create K8S namespaces and launch manifests"
}