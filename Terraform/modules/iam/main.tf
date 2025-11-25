resource "aws_security_group" "Task6-ALB-SG-Zaeem" {
    vpc_id = var.vpc_id

    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
 
}

resource "aws_security_group" "Task6-EFS-SG-Zaeem" {
    vpc_id = var.vpc_id


    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group_rule" "ec2_to_efs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.Task6-EFS-SG-Zaeem.id
  source_security_group_id = aws_security_group.Task6-EC2-SG-Zaeem.id
}

resource "aws_security_group" "Task6-EC2-SG-Zaeem" {
    vpc_id = var.vpc_id
    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
}

# resource "aws_security_group_rule" "EC2-allow-from-ALB-Zaeem" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.Task6-EC2-SG-Zaeem.id
#   source_security_group_id = aws_security_group.Task6-ALB-SG-Zaeem.id
# }

resource "aws_iam_role" "Task6-ecs-task-role-Zaeem" {
  name = "Task6-ecs-task-role-Zaeem"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "Task6-ecs-task-role-policy-Zaeem" {
  name = "Task6-ecs-task-role-policy-Zaeem"
  role = aws_iam_role.Task6-ecs-task-role-Zaeem.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "elasticfilesystem:ClientRootAccess",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientMount"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRoleZaeem"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "ecsInstanceRoleZaeem"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_efs_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "Task6-Instance-Profile-Zaeem" {
  name = "ecsInstanceProfileZaeem"
  role = aws_iam_role.ecs_instance_role.name
}
