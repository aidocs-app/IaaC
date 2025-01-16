# Variables for tags and naming
variable "environment" {
  description = "Environment for the resources (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name for tagging and naming"
  type        = string
  default     = "aidocs"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_count" {
  description = "Number of subnets"
  type        = number
  default     = 2
}

# Variables for RDS
variable "db_username" {
  description = "Username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
  default     = "aidocsdb"
}

variable "ecr_image_uri" {
  description = "URI of the Docker image in ECR"
  type        = string
}

variable "langsmith_api_key" {
  description = "API key for LangSmith"
  type        = string
}

variable "openai_api_key" {
  description = "API key for OpenAI"
  type        = string
}

variable "together_ai_api_key" {
  description = "API key for Together AI"
  type        = string
}

variable "github_access_token" {
  description = "GitHub Personal Access Token for Amplify"
  type        = string
  sensitive   = true
}
