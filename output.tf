#######################################################
# pet name
#######################################################
output "random_pet" {
  value       = random_pet.this.id
  description = "Outputs for the random_pet module"
}

#######################################################
# vpc
#######################################################
output "vpc" {
  value       = module.vpc
  description = "Outputs for the vpc module"
}

#######################################################
# eks
#######################################################
output "eks" {
  value       = module.eks
  description = "Outputs for the eks module"
}

#######################################################
# kubernetes
#######################################################
output "kubernetes" {
  value       = module.kubernetes
  sensitive   = true
  description = "Outputs for the mongodb module"
}