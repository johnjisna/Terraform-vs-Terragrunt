include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
}

terraform {
  source = "${get_repo_root()}/modules/rds"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id             = "vpc-00000000"
    private_subnet_ids = ["subnet-00000001", "subnet-00000002"]
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "eks" {
  config_path = "../eks"

  mock_outputs = {
    node_security_group_id = "sg-00000000"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = {
  identifier                = "${local.env.project}-${local.env.environment}-postgres"
  vpc_id                    = dependency.vpc.outputs.vpc_id
  subnet_ids                = dependency.vpc.outputs.private_subnet_ids
  allowed_security_group_id = dependency.eks.outputs.node_security_group_id
  instance_class            = local.env.db_instance_class
  allocated_storage         = local.env.db_allocated_storage
  multi_az                  = local.env.db_multi_az
  backup_retention_period   = local.env.db_backup_retention_period
  deletion_protection       = local.env.db_deletion_protection
}
