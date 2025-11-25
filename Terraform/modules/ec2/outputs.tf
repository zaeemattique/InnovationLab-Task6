output "asg_arn" {
  value = aws_autoscaling_group.Task6-ECS-Auto-Scaling-Group-Zaeem.arn
}

output "asg_id" {
  value = aws_autoscaling_group.Task6-ECS-Auto-Scaling-Group-Zaeem.id
}

output "launchtemp_arn" {
  value = aws_launch_template.Task6-ECS-Launch-Template-Zaeem.arn
}

output "launchtemp_id" {
  value = aws_launch_template.Task6-ECS-Launch-Template-Zaeem.id
}