#######################################################
# provider
#######################################################
variable "region" {
    type        = string
    description = "The region the provider will be configured for." 
}

#######################################################
# vpc
#######################################################
variable "cidr" {
    type        = string
    description = "RFC1918 CIDR block for the VPC." 
}

#######################################################
# local kubeconfig setup
#######################################################
variable "kubeconfig" {
    type        = bool
    description = "Triggers an optional local kubeconfig setup - don't use in pipeline."
    default     = false
}