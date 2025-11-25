module "vpc" {
  source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    public_sna_cidr = var.public_sna_cidr
    public_snb_cidr = var.public_snb_cidr
    private_sna_cidr = var.private_sna_cidr
    private_snb_cidr = var.private_snb_cidr

}

module "ecs" {
  source = "./modules/ecs"
    efs_id = module.efs.efs_id
    efs_ap_id = module.efs.efs_ap_id
    alb_tg_arn = module.alb.alb_tg_arn
    ecs_task_role_arn = module.iam.ecs_task_role_arn
    ecs_execution_role_arn = module.iam.ecs_execution_role_arn
    asg_arn = module.ec2.asg_arn
    asg_id = module.ec2.asg_id
    launchtemp_arn = module.ec2.launchtemp_arn
    launchtemp_id = module.ec2.launchtemp_id
}

module "ec2" {
  source = "./modules/ec2"
    private_sna_id = module.vpc.private_sna_id
    private_snb_id = module.vpc.private_snb_id
    ec2_sg_id = module.iam.ec2_sg_id
    ecs_instance_profile_arn = module.iam.ecs_instance_profile_arn
    efs_id = module.efs.efs_id
}

module "alb" {
  source = "./modules/alb"
  public_sna_id = module.vpc.public_sna_id
  public_snb_id = module.vpc.public_snb_id
  alb_sg_id = module.iam.alb_sg_id
  vpc_id = module.vpc.vpc_id
}

module "efs" {
  source = "./modules/efs"
  private_sna_id = module.vpc.private_sna_id
  efs_sg_id = module.iam.efs_sg_id
  private_snb_id = module.vpc.private_snb_id
  
}

module "iam" {
  source = "./modules/iam"
  vpc_id = module.vpc.vpc_id
}

