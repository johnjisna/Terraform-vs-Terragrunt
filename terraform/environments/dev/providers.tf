provider "aws" {
  region = var.region

  # Safety net: refuses to run if your credentials point at the wrong account
  allowed_account_ids = [var.account_id]

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
