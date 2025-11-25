output "alb_id" {
  value = aws_lb.Task6-ALB-Zaeem.id
}

output "alb_tg_arn" {
  value = aws_lb_target_group.Task6-ALB-Target-Group-Zaeem.arn
}