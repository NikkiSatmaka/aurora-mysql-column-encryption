output "rds_cluster_endpoint" {
  description = "Aurora MySQL cluster endpoint"
  value       = module.aurora_mysql.this_rds_cluster_endpoint
}

output "rds_cluster_port" {
  description = "Aurora MySQL cluster port"
  value       = module.aurora_mysql.this_rds_cluster_port
}
