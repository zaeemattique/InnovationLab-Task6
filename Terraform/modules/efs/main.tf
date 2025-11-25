resource "aws_efs_file_system" "Task6-EFS-Zaeem" {
  creation_token = "Task6-EFS-Zaeem"
  performance_mode = "generalPurpose"
  encrypted = true
  tags = {
    Name = "Task6-EFS-Zaeem"
  }

}

resource "aws_efs_access_point" "Task6-EFS-Access-Point-Zaeem" {
  file_system_id = aws_efs_file_system.Task6-EFS-Zaeem.id

  posix_user {
    uid = 1000
    gid = 1000
  }

  root_directory {
    path = "/"

    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "755"
    }
  }
  
}

resource "aws_efs_mount_target" "Task6-EFS-Mount-TargetA-Zaeem" {
  file_system_id  = aws_efs_file_system.Task6-EFS-Zaeem.id
  subnet_id       = var.private_sna_id
  security_groups = [var.efs_sg_id]
}

resource "aws_efs_mount_target" "Task6-EFS-Mount-TargetB-Zaeem" {
  file_system_id  = aws_efs_file_system.Task6-EFS-Zaeem.id
  subnet_id       = var.private_snb_id
  security_groups = [var.efs_sg_id]
}