project     = "demo"
environment = "dev"
account_id  = "111111111111"
region      = "ap-south-1"

vpc_cidr           = "10.10.0.0/16"
azs                = ["ap-south-1a", "ap-south-1b"]
private_subnets    = ["10.10.1.0/24", "10.10.2.0/24"]
public_subnets     = ["10.10.101.0/24", "10.10.102.0/24"]
single_nat_gateway = true

cluster_version     = "1.33"
node_instance_types = ["t3.large"]
node_min_size       = 2
node_max_size       = 4
node_desired_size   = 2

db_instance_class          = "db.t4g.medium"
db_allocated_storage       = 20
db_multi_az                = false
db_backup_retention_period = 1
db_deletion_protection     = false

# Replace with your trusted admin or CI runner public IP/CIDR before apply.
# This documentation-only range is not a usable client address.
cluster_endpoint_public_access_cidrs = ["203.0.113.10/32"]
