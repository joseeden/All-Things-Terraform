# lab06 - Provisioning a VPC with ALB and autoscaling group and 
# deploying a cloud-native application
#---------------------------------------------------------------

module "network" {
  source = "./modules/network"

  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
}

module "security" {
  source = "./modules/security"

  vpc_id         = module.network.vpc_id
  workstation_ip = var.my_ip

  depends_on = [
    module.network
  ]
}

module "bastion" {
  source = "./modules/bastion"

  instance_ami  = var.instance_ami
  instance_type = var.bastion_instance_type
  key_name      = var.key_pair
  subnet_id     = module.network.public_subnets[0]
  sg_id         = module.security.bastion_sg_id

  depends_on = [
    module.network,
    module.security
  ]
}

module "storage" {
  source        = "./modules/storage"
  instance_ami  = var.instance_ami
  instance_type = var.db_instance_type
  key_name      = var.key_pair
  subnet_id     = module.network.private_subnets[0]
  sg_id         = module.security.mongodb_sg_id

  depends_on = [
    module.network,
    module.security
  ]
}

module "application" {
  source = "./modules/application"

  instance_type   = var.app_instance_type
  key_name        = var.key_pair
  vpc_id          = module.network.vpc_id
  public_subnets  = module.network.public_subnets
  private_subnets = module.network.private_subnets
  webserver_sg_id = module.security.application_sg_id
  alb_sg_id       = module.security.alb_sg_id
  mongodb_ip      = module.storage.private_ip

  depends_on = [
    module.network,
    module.security,
    module.storage
  ]
}


