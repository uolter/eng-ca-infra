module "vpc" {
  source                = "terraform-aws-modules/vpc/aws"
  version               = "5.1.1"
  name                  = format("%s-vpc", local.project)
  cidr                  = var.vpc_cidr
  azs                   = var.azs
  private_subnets       = var.vpc_private_subnets_cidr
  private_subnet_suffix = "private"
  public_subnets        = var.vpc_public_subnets_cidr
  public_subnet_suffix  = "public"
  intra_subnets         = var.vpc_internal_subnets_cidr
  enable_nat_gateway    = var.enable_nat_gateway
  single_nat_gateway    = true
  reuse_nat_ips         = false


  enable_dns_hostnames          = true
  enable_dns_support            = true
  map_public_ip_on_launch       = true
  manage_default_security_group = false
  manage_default_network_acl    = false
  manage_default_route_table    = false

}

resource "aws_security_group" "vault" {
  name        = "Vault server required ports"
  vpc_id      = module.vpc.vpc_id
  description = "Security group for HashiCorp Vault"
}

resource "aws_security_group_rule" "vault_api_tcp" {
  type              = "ingress"
  description       = "Vault API/UI"
  security_group_id = aws_security_group.vault.id
  from_port         = 8200
  to_port           = 8200
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_web" {
  type              = "egress"
  description       = "Internet access"
  security_group_id = aws_security_group.vault.id
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}