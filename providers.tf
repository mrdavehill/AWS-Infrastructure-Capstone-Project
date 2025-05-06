#######################################################
# required providers
#######################################################
terraform {
  required_providers {
    aws        = {
      source   = "hashicorp/aws"
      version  = "~> 5.0"
    }
    kubectl    = {
      source   = "gavinbunney/kubectl"
      version  = ">= 1.7.0"
    }
    random     = {
      source   = "hashicorp/random"
      version  = "3.7.2"
    }
  }
  backend "s3" {
    bucket = 232413781559-eu-west-1
    key    ="/'
    region = eu-west-1 
  }
}

#######################################################
# provider configuration
#######################################################
provider "aws" { 
  region  = var.region 
}

provider "kubectl" {
  host                   = try(module.eks.cluster_endpoint, "foo")
  cluster_ca_certificate = try(base64decode(module.eks.cluster_certificate_authority_data), "bar")
  exec {
    api_version          = "client.authentication.k8s.io/v1"
    args                 = ["eks", "get-token", "--cluster-name", random_pet.this.id]
    command              = "aws"
  }
}