# Network Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.open.id
}

# Database Outputs
output "db_endpoint" {
  description = "The endpoint of the RDS PostgreSQL database"
  value       = aws_db_instance.postgresql.endpoint
}

output "redis_endpoint" {
  description = "The endpoint of the Redis cluster"
  value       = "${aws_elasticache_cluster.redis.cache_nodes[0].address}:${aws_elasticache_cluster.redis.port}"
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.backend.dns_name
}

output "amplify_log_group" {
  description = "The CloudWatch log group for Amplify"
  value       = "/aws/amplify/${aws_amplify_app.frontend.id}"
}
