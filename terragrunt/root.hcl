# Root config: written ONCE, inherited by every stack under live/.
# Terragrunt generates backend.tf and providers.tf for us.

locals {
  env        = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
  project    = local.env.project
  account_id = local.env.account_id
  region     = local.env.region
}

# Replaces the hand-written backend.tf in every environment.
# key is built from the folder path, so every stack gets its own state file.
remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket       = "mycompany-tfstate-${local.account_id}"
    key          = "${local.project}/${path_relative_to_include()}/terraform.tfstate"
    region       = local.region
    encrypt      = true
    use_lockfile = true
  }
}

# Replaces the hand-written providers.tf in every environment.
generate "provider" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region              = "${local.region}"
  allowed_account_ids = ["${local.account_id}"]

  default_tags {
    tags = {
      Project     = "${local.project}"
      Environment = "${local.env.environment}"
      ManagedBy   = "terragrunt"
    }
  }
}
EOF
}
