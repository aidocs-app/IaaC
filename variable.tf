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
