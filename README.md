## Hello friends

This is a custom Terraform to spin up an auto-mode EKS cluster in a new dedicated VPC, load Mongodb, Mongo Express and create an Ingress so it's externally accessable.

You'll need a jumpbox with the correctly patched software to run terreaform apply and an s3 bucket for remote state - use this repo to build them both: [GitHub Repo](https://github.com/mrdavehill/AWS-Infrastructure-Capstone-Jumpbox)

Once spun up, access the Mongo Express UI from the ALB DNS A Name using the creds below:

Username: username  
Password: password

And you'll be greeted by this:

![Mongo Express UI](https://github.com/mrdavehill/AWS-Infrastructure-Capstone-Project/blob/main/images/UI.png)

## A bit about Mongodb and Mongo Express

Why Mongo Express? It's a containerised, multi-tiered app that uses configmaps, secrets, services, deployments and an ingress - all the good stuff and simple enough to troubleshoot with a small amount of knowledge.

Here's the sales pitch:

MongoDB is an open-source, NoSQL document database. It's designed to be flexible and scalable, allowing developers to store and retrieve data in a document-oriented format using JSON-like structures. Unlike traditional relational databases, MongoDB doesn't require predefined schemas, making it easier to work with unstructured or semi-structured data. 

Mongo Express is a web-based administrative tool for managing MongoDB databases. It provides a user-friendly interface for interacting with MongoDB, allowing users to view, add, delete, and modify databases, collections, and documents. Built using Node.js, Express.js, and Bootstrap, it simplifies common MongoDB administration tasks.

The objects instantiated here create the environment below (not with the NGINX ingress tho):

![Mongo EKS Environment](https://github.com/mrdavehill/AWS-Infrastructure-Capstone-Project/blob/main/images/Mongo.png)

## Caveat

There's an issue with Apple silicon and the kubectl provider. I have run this succesfully from an Amazon Linux ec2 updated to the latest version of AWS CLI but it fails on my Macbook. 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_awscli"></a> [awscli](#requirement\_awscli) | >= 2.27.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
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
| [null_resource.this](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/3.7.2/docs/resources/pet) | resource |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | RFC1918 CIDR block for the VPC. | `string` | n/a | yes |
| <a name="input_kubeconfig"></a> [kubeconfig](#input\_kubeconfig) | Triggers an optional local kubeconfig setup - don't use in pipeline. | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | The region the provider will be configured for. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks"></a> [eks](#output\_eks) | Outputs for the eks module |
| <a name="output_mongodb"></a> [mongodb](#output\_mongodb) | Outputs for the mongodb module |
| <a name="output_random_pet"></a> [random\_pet](#output\_random\_pet) | Outputs for the random\_pet module |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Outputs for the vpc module |
<!-- END_TF_DOCS -->
