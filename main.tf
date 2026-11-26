module "networking" {
  source = "./modules/networking"
}

module "security" {
  source = "./modules/security"

  vpc_id           = module.networking.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
  public_key_path  = var.public_key_path
}

module "storage" {
  source      = "./modules/storage"
  bucket_name = var.bucket_name
}

module "compute" {
  source = "./modules/compute"

  public_subnet_id   = module.networking.public_subnet_id
  web_security_group = module.security.web_security_group_id
  key_pair_name      = module.security.key_pair_name
}
