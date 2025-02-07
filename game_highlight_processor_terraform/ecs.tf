# ecs.tf

# Create an ECS cluster with the project name
resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-cluster"
}

# Create a CloudWatch log group for ECS logs with 7 day retention
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 7
}

# Define the ECS task definition with Fargate compatibility
resource "aws_ecs_task_definition" "this" {
  family                   = "${var.project_name}-task"
  cpu                      = 1024 # 1 vCPU
  memory                   = 2048 # 2GB RAM
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  depends_on               = [aws_ecr_repository.this, aws_iam_role.ecs_task_execution_role, docker_registry_image.image]

  # Define container configuration using JSON encoding
  container_definitions = jsonencode([
    {
      name  = "${var.project_name}"
      image = "${aws_ecr_repository.this.repository_url}:latest"

      # Configure CloudWatch logging
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }

      # Set environment variables for the container
      environment = [
        {
          name  = "API_URL"
          value = var.api_url
        },
        {
          name  = "RAPIDAPI_HOST"
          value = var.rapidapi_host
        },
        {
          name  = "RAPIDAPI_KEY"
          value = var.rapidapi_key
        },

        {
          name  = "LEAGUE_NAME"
          value = var.league_name
        },
        {
          name  = "DATE"
          value = var.date
        },

        {
          name  = "LIMIT"
          value = var.limit
        },

        {
          name  = "INPUT_KEY"
          value = var.input_key
        },
        {

          name  = "OUTPUT_KEY"
          value = var.output_key
        },

        {
          name  = "AWS_REGION"
          value = var.aws_region
        },
        {
          name  = "S3_BUCKET_NAME"
          value = var.s3_bucket_name
        },
        {
          name  = "MEDIACONVERT_ENDPOINT"
          value = var.mediaconvert_endpoint
        },
        {
          name  = "RETRY_COUNT"
          value = var.retry_count
        },
        {
          name = "RETRY_DELAY"

          value = var.retry_delay
        },
        {
          name  = "WAIT_TIME_BETWEEN_SCRIPTS"
          value = var.wait_time_between_scripts
        },
        {
          name  = "MEDIACONVERT_ROLE_ARN"
          value = "${aws_iam_role.mediaconvert_role.arn}"
        }

      ]
 
    }
  ])
}

# Create an ECS service to run the task definition
resource "aws_ecs_service" "this" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  # Configure networking for the service
  network_configuration {
    subnets          = [aws_subnet.public_subnet.id]
    security_groups  = [aws_security_group.ecs_task.id]
    assign_public_ip = true
  }

  # Set deployment controller type to ECS
  deployment_controller {
    type = "ECS"
  }

  # Add tags for resource identification
  tags = {
    Name = "${var.project_name}-service"
  }
}
