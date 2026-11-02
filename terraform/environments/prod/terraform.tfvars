project     = "demo"
environment = "prod"
account_id  = "222222222222"
region      = "ap-south-1"

vpc_cidr           = "10.20.0.0/16"
azs                = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
private_subnets    = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
public_subnets     = ["10.20.101.0/24", "10.20.102.0/24", "10.20.103.0/24"]
single_nat_gateway = false

cluster_version     = "1.33"
node_instance_types = ["m5.xlarge"]
node_min_size       = 3
node_max_size       = 10
node_desired_size   = 6

db_instance_class          = "db.m6g.large"
db_allocated_storage       = 100
db_multi_az                = true
db_backup_retention_period = 14
db_deletion_protection     = true

# Replace with your trusted admin or CI runner public IP/CIDR before apply.
# This documentation-only range is not a usable client address.
cluster_endpoint_public_access_cidrs = ["203.0.113.10/32"]
