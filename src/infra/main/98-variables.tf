variable "aws_region" {
  type        = string
  description = "AWS region to create resources. Default Milan"
  default     = "eu-west-1"
}

variable "app_name" {
  type        = string
  description = "App name."
  default     = "ca"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment"
}

variable "env_short" {
  type        = string
  default     = "d"
  description = "Evnironment short."
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC cidr."
}

variable "azs" {
  type        = list(string)
  description = "Availability zones"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_private_subnets_cidr" {
  type        = list(string)
  description = "Private subnets list of cidr."
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnets_cidr" {
  type        = list(string)
  description = "Private subnets list of cidr."
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "vpc_internal_subnets_cidr" {
  type        = list(string)
  description = "Internal subnets list of cidr. Mainly for private endpoints"
  default     = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable/Create nat gateway"
  default     = true
}

## Public Dns zones
variable "public_dns_zones" {
  type        = map(any)
  description = "Route53 Hosted Zone"
  default     = null
}

variable "dns_record_ttl" {
  type        = number
  description = "Dns record ttl (in sec)"
  default     = 86400 # 24 hours
}

#-------------------------
# ECR
#-------------------------
variable "ecr_name" {
  description = "Name of Elastic Container Registry repo."
  default     = "vault"
}


#-------------------------
# S3
#-------------------------
variable "s3_bucket_name" {
  description = "Name of S3 Storage Bucket used for Vault backend"
  default     = "vault-storage"
}


#-------------------------
# ECS
#-------------------------
variable "ecs_cluster_name" {
  description = "Name of ECS Cluster"
  default     = "vault-ecs-cluster"
}

variable "ecs_service_name" {
  default = "vault-ecs-service"
}

variable "ecs_logs_retention_days" {
  type        = number
  description = "ECS log group retention in days"
  default     = 5
}


#-------------------------
# HashiCorp Vault
#-------------------------
variable "vault_version" {
  default = "1.14.6"
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
