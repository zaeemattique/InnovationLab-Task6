output "efs_id" {
  value = aws_efs_file_system.Task6-EFS-Zaeem.id
}

output "efs_mt1_id" {
  value = aws_efs_mount_target.Task6-EFS-Mount-TargetA-Zaeem.id
}

output "efs_mt2_id" {
  value = aws_efs_mount_target.Task6-EFS-Mount-TargetB-Zaeem.id
}

output "efs_ap_id" {
  value = aws_efs_access_point.Task6-EFS-Access-Point-Zaeem.id
}