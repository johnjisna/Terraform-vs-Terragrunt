include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
}

terraform {
  source = "${get_repo_root()}/modules/eks"
}

# "EKS needs the VPC": Terragrunt applies vpc first and passes its outputs in.
dependency "vpc" {
  config_path = "../vpc"

  # Lets init/validate/plan work before the VPC exists. Never used for apply.
  mock_outputs = {
    vpc_id             = "vpc-00000000"
    private_subnet_ids = ["subnet-00000001", "subnet-00000002"]
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = {
  cluster_name        = "${local.env.project}-${local.env.environment}"
  cluster_version     = local.env.cluster_version
  cluster_endpoint_public_access_cidrs = local.env.cluster_endpoint_public_access_cidrs
  vpc_id              = dependency.vpc.outputs.vpc_id
  subnet_ids          = dependency.vpc.outputs.private_subnet_ids
  node_instance_types = local.env.node_instance_types
  node_min_size       = local.env.node_min_size
  node_max_size       = local.env.node_max_size
  node_desired_size   = local.env.node_desired_size
}
