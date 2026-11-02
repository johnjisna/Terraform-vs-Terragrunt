variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  description = "Kubernetes version (check the latest version EKS supports)"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  description = "Private subnets for nodes and control plane ENIs"
  type        = list(string)
}

variable "node_instance_types" {
  type = list(string)
}

variable "node_min_size" {
  type = number
}

variable "node_max_size" {
  type = number
}

variable "node_desired_size" {
  type = number
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "Public IPv4 CIDRs allowed to reach the EKS Kubernetes API endpoint. Replace the documentation-only placeholder before deployment."
  type        = list(string)
}
