output "cluster_endpoint" {
  description = "Aurora MySQL cluster endpoint"
  value       = module.mysql_cluster.cluster_endpoint
}

output "cluster_port" {
  description = "Aurora MySQL cluster port"
  value       = module.mysql_cluster.cluster_port
}
