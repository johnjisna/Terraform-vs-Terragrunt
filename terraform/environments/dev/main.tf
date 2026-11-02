locals {
  name = "${var.project}-${var.environment}"
}

module "vpc" {
  source = "../../../modules/vpc"

  name               = local.name
  cidr               = var.vpc_cidr
  azs                = var.azs
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  single_nat_gateway = var.single_nat_gateway
}

module "eks" {
  source = "../../../modules/eks"

  cluster_name        = local.name
  cluster_version     = var.cluster_version
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.private_subnet_ids
  node_instance_types = var.node_instance_types
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  node_desired_size   = var.node_desired_size
}

module "rds" {
  source = "../../../modules/rds"

  identifier                = "${local.name}-postgres"
  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.private_subnet_ids
  allowed_security_group_id = module.eks.node_security_group_id
  instance_class            = var.db_instance_class
  allocated_storage         = var.db_allocated_storage
  multi_az                  = var.db_multi_az
  backup_retention_period   = var.db_backup_retention_period
  deletion_protection       = var.db_deletion_protection
}
