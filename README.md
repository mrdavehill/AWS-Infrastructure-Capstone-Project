# AWS-Infrastructure-Capstone-Project

Custom Terraform to spin up an auto-mode EKS cluster, load Mongodb Express and an Ingress.

And often with a funny name.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 20.31 |
| <a name="module_mongodb"></a> [mongodb](#module\_mongodb) | ./modules/mongodb-express | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.21.0 |

## Resources

| Name | Type |
|------|------|
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/3.7.2/docs/resources/pet) | resource |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | RFC1918 CIDR block for the VPC. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region the provider will be configured for | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks"></a> [eks](#output\_eks) | Outputs for the eks module |
| <a name="output_mongodb"></a> [mongodb](#output\_mongodb) | Outputs for the mongodb module |
| <a name="output_random_pet"></a> [random\_pet](#output\_random\_pet) | Outputs for the random\_pet module |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Outputs for the vpc module |
<!-- END_TF_DOCS -->