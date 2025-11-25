output "efs_sg_id" {
  value = aws_security_group.Task6-EFS-SG-Zaeem.id
}

output "alb_sg_id" {
  value = aws_security_group.Task6-ALB-SG-Zaeem.id
}

output "ec2_sg_id" {
  value = aws_security_group.Task6-EC2-SG-Zaeem.id
}

output "ecs_task_role_arn" {
  value = aws_iam_role.Task6-ecs-task-role-Zaeem.arn
}

output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_instance_profile_arn" {
  value = aws_iam_instance_profile.Task6-Instance-Profile-Zaeem.arn
}