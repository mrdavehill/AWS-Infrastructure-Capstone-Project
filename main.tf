#######################################################
# pet name
#######################################################
resource "random_pet" "this" {}

#######################################################
# vpc
#######################################################
module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "5.21.0"
  name                 = random_pet.this.id
  cidr                 = var.cidr
  azs                  = slice(data.aws_availability_zones.this.names, 0, 3)
  private_subnets      = [cidrsubnet(var.cidr, 4, 0), cidrsubnet(var.cidr, 4, 1), cidrsubnet(var.cidr, 4, 2)]
  public_subnets       = [cidrsubnet(var.cidr, 4, 3), cidrsubnet(var.cidr, 4, 4), cidrsubnet(var.cidr, 4, 5)]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  public_subnet_tags = {
    "kubernetes.io/cluster/${random_pet.this.id}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${random_pet.this.id}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}

#######################################################
# eks cluster
#######################################################
module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "~> 20.31"
  cluster_name                             = random_pet.this.id
  cluster_version                          = "1.32"
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true
  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}

#######################################################
# kubernetes
#######################################################
module "kubernetes" {
  source = "./modules/kubernetes"
  yaml   = local.yaml
}