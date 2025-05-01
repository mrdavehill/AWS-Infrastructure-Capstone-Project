#######################################################
# pet name
#######################################################
output "random_pet" {
    value = random_pet.this.id
}

#######################################################
# vpc
#######################################################
output "vpc"{
    value = module.vpc
}

#######################################################
# eks
#######################################################
output "eks"{
    value = module.eks
}

#######################################################
# mongodb express
#######################################################
output "mongodb"{
    value     = module.mongodb
    sensitive = true
}

output "mongodb-ingress-dns-name"{
    value     = module.mongodb.mongodb-ingress-dns-name
}