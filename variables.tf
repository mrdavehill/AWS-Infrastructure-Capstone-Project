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
variable "vpc_switch" {
    type        = bool
    description = "Conditional toggle switch for VPC module"
    default     = true
}

variable "cidr" {
    type        = string
    description = "RFC1918 CIDR block for the VPC." 
}

#######################################################
# eks cluster
#######################################################
variable "eks_switch" {
    type        = bool
    description = "Conditional toggle switch for EKS module"
    default     = true
}

#######################################################
# mongodb express
#######################################################
variable "mongodb_switch" {
    type        = bool
    description = "Conditional toggle switch for mongodb module"
    default     = true
}