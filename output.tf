# Outputs
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "security_group_id" {
  value = aws_security_group.open.id
}

# Output for RDS Database Endpoint
output "db_endpoint" {
  description = "The endpoint of the RDS PostgreSQL database"
  value       = aws_db_instance.postgresql.endpoint
}

# Output for ElastiCache Redis Endpoint
output "redis_endpoint" {
  description = "Endpoint for the Redis cluster"
  value       = "${aws_elasticache_cluster.redis.cache_nodes[0].address}:${aws_elasticache_cluster.redis.port}"
}
