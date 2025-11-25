resource "aws_ecs_cluster" "Task6-ECS-Cluster-Zaeem" {
  name = "Task6-ECS-Cluster-Zaeem"
   
}

resource "aws_ecs_capacity_provider" "Task6-ECS-Capacity-Provider-Zaeem" {
  name = "Task6-ECS-Capacity-Provider-Zaeem"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.asg_arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 80
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "Task6-ECS-Cluster-Capacity-Providers-Zaeem" {
  cluster_name = aws_ecs_cluster.Task6-ECS-Cluster-Zaeem.name
  capacity_providers = [
    aws_ecs_capacity_provider.Task6-ECS-Capacity-Provider-Zaeem.name
  ]
  
}

resource "aws_ecs_task_definition" "Task6-ECS-Task-Definition-Zaeem" {
  depends_on = [ var.efs_id ]
  family = "Task6-ECS-Task-Definition-Zaeem"
  network_mode = "bridge"
  requires_compatibilities = ["EC2"]
  cpu       = "256"
  memory    = "512"
  task_role_arn = var.ecs_task_role_arn
  execution_role_arn = var.ecs_execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "NginxServer"
      image     = "nginx:latest"

      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  volume {
    name = "Task6-EFS-Zaeem"

    efs_volume_configuration {
      file_system_id          = var.efs_id
      root_directory          = "/"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2999
      authorization_config {
        access_point_id = var.efs_ap_id
        iam             = "ENABLED"
      }
    }
  }
}

resource "aws_ecs_service" "Task6-ECS-Service-Zaeem" {
  name            = "Task6-ECS-Service-Zaeem"
  cluster         = aws_ecs_cluster.Task6-ECS-Cluster-Zaeem.id
  task_definition = aws_ecs_task_definition.Task6-ECS-Task-Definition-Zaeem.arn
  desired_count   = 2
  launch_type     = "EC2"
  depends_on = [var.alb_tg_arn]
  load_balancer {
    target_group_arn = var.alb_tg_arn
    container_name   = "NginxServer"
    container_port   = 80
  }

}