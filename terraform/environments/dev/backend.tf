# Backend blocks cannot use variables, so this file is hard-coded
# and has to be copied (and edited) for every environment.
terraform {
  backend "s3" {
    bucket       = "mycompany-tfstate-111111111111"
    key          = "demo/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true # S3 native locking (Terraform >= 1.10), no DynamoDB table needed
  }
}
