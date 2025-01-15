locals {
  backend_environment_variables = [
    {
      name  = "DATABASE_USER"
      value = var.db_username
    },
    {
      name  = "DATABASE_PASSWORD"
      value = var.db_password
    },
    {
      name  = "DATABASE_HOST"
      value = aws_db_instance.postgresql.address
    },
    {
      name  = "DATABASE_PORT"
      value = tostring(aws_db_instance.postgresql.port)
    },
    {
      name  = "DATABASE_NAME"
      value = var.db_name
    },
    {
      name  = "DATABASE_URI"
      value = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.postgresql.endpoint}/${var.db_name}"
    },
    {
      name  = "REDIS_URI"
      value = "redis://${aws_elasticache_cluster.redis.cache_nodes[0].address}:${aws_elasticache_cluster.redis.port}"
    },
    {
      name  = "LANGSMITH_API_KEY"
      value = var.langsmith_api_key
    },
    {
      name  = "OPENAI_API_KEY"
      value = var.openai_api_key
    },
    {
      name  = "TOGETHER_AI_API_KEY"
      value = var.together_ai_api_key
    },
    {
      name  = "DATABASE_SSL"
      value = "true"
    },
    {
      name  = "NODE_TLS_REJECT_UNAUTHORIZED"
      value = "0"
    }
  ]
}
