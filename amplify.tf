resource "aws_amplify_app" "frontend" {
  name                        = "${var.project_name}-frontend"
  repository                  = "https://github.com/aidocs-app/aidocs-app"
  access_token                = var.github_access_token
  enable_basic_auth           = false
  enable_branch_auto_build    = false
  enable_auto_branch_creation = false
  platform                    = "WEB_COMPUTE"
  iam_service_role_arn        = aws_iam_role.amplify_cloudwatch.arn
  build_spec                  = file("amplify.yml")
  # Environment variables
  environment_variables = {
    NEXT_PUBLIC_LANGGRAPH_API_URL = "http://${aws_lb.backend.dns_name}"
  }

  tags = {
    Name        = "${var.project_name}-frontend"
    Environment = var.environment
    Project     = var.project_name
  }

  depends_on = [aws_ecs_service.backend]
}

# Branch configuration
resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.frontend.id
  branch_name = "main"
  framework   = "Next.js - SSR"
  stage       = "PRODUCTION"

  environment_variables = {
    NEXT_PUBLIC_LANGGRAPH_API_URL = "http://${aws_lb.backend.dns_name}"
  }

  depends_on = [aws_ecs_service.backend]
}

# CloudWatch Log Group for Amplify
resource "aws_cloudwatch_log_group" "amplify" {
  name              = "/aws/amplify/${aws_amplify_app.frontend.id}"
  retention_in_days = 30

  tags = {
    Name        = "${var.project_name}-amplify-logs"
    Environment = var.environment
    Project     = var.project_name
  }
}

# IAM role for Amplify to write logs to CloudWatch
resource "aws_iam_role" "amplify_cloudwatch" {
  name = "${var.project_name}-amplify-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "amplify.amazonaws.com"
        }
      }
    ]
  })
}

# IAM policy for CloudWatch logging
resource "aws_iam_role_policy" "amplify_cloudwatch" {
  name = "${var.project_name}-amplify-cloudwatch-policy"
  role = aws_iam_role.amplify_cloudwatch.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = [
          "arn:aws:logs:${var.region}:*:log-group:/aws/amplify/*",
          "arn:aws:logs:${var.region}:*:log-group:/aws/amplify/*:*"
        ]
      }
    ]
  })
}
