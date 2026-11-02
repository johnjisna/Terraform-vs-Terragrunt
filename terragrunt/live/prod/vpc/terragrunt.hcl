include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
}

terraform {
  source = "${get_repo_root()}/modules/vpc"
}

inputs = {
  name               = "${local.env.project}-${local.env.environment}"
  cidr               = local.env.vpc_cidr
  azs                = local.env.azs
  private_subnets    = local.env.private_subnets
  public_subnets     = local.env.public_subnets
  single_nat_gateway = local.env.single_nat_gateway
}
