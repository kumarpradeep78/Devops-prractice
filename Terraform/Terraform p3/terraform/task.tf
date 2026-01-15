resource "aws_ecs_task_definition" "flask" {
  family                   = "flask-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
    execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "flask"
      image = "${aws_ecr_repository.flask.repository_url}:latest"
      memory = 256
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "express" {
  family                   = "express-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
    execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "express"
      image = "${aws_ecr_repository.express.repository_url}:latest"
      memory = 256
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}
