data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "Task6-ECS-Launch-Template-Zaeem" {
  name_prefix   = "Task6-ECS-Launch-Template-Zaeem"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = "t3.micro"
  iam_instance_profile {
    arn = var.ecs_instance_profile_arn
  }
  network_interfaces {
    associate_public_ip_address = false
    device_index                = 0
    security_groups             = [var.ec2_sg_id]
    delete_on_termination       = true
  }
  user_data = base64encode(<<-EOF
  #!/bin/bash
  set -e

  # Ensure cluster name is set
  echo "ECS_CLUSTER=Task6-ECS-Cluster-Zaeem" > /etc/ecs/ecs.config

  # If using a non-ECS-optimized AMI, install the agent (this will no-op on optimized AMI)
  if ! command -v amazon-ecs-agent >/dev/null 2>&1; then
    # Amazon Linux 2 example — update & install
    yum update -y
    yum install -y amazon-ecs-init
    systemctl enable --now amazon-ecs
  else
    # Ensure the agent is running
    systemctl enable --now amazon-ecs
  fi

  # Restart agent to pick up cluster change
  systemctl restart amazon-ecs || true
EOF
)
  
}

resource "aws_autoscaling_group" "Task6-ECS-Auto-Scaling-Group-Zaeem" {
  
  launch_template {
    id      = aws_launch_template.Task6-ECS-Launch-Template-Zaeem.id
    version = "$Latest"
  }
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
  vpc_zone_identifier       = [
    var.private_sna_id,
    var.private_snb_id
  ]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  
  tag {
    key                 = "Name"
    value               = "Task6-ECS-Instance-Zaeem"
    propagate_at_launch = true
  }
}