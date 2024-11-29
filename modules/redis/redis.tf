resource "aws_elasticache_parameter_group" "redis7_param_group" {
  name        = "redis7-parameter-group"
  family      = "redis7"
  description = "Parameter group for Redis 7"
}


resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = var.redis_name
  engine               = "redis"
  engine_version       = "7.0"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis7_param_group.name

  tags = {
    Name = "Redis-Cluster"
  }
}

