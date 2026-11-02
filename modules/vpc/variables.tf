variable "name" {
  description = "Name prefix for the VPC"
  type        = string
}

variable "cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "azs" {
  description = "Availability zones to use"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs (one per AZ)"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDRs (one per AZ)"
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "true = one shared NAT (cheap, for dev). false = one NAT per AZ (HA, for prod)"
  type        = bool
  default     = false
}
