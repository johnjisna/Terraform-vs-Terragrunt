output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_security_group_id" {
  description = "Security group attached to worker nodes (used to allow DB access)"
  value       = module.eks.node_security_group_id
}
