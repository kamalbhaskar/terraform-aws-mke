module "common" {
    source = "./modules/common"
    public_key = var.public_key
}

module "manager" {
    source = "./modules/manager"
    instancetype = var.instancetype
    sshkeypair = module.common.sshkeypair
    security_group_id = module.common.security_group_id
    subnet_id = module.common.subnet_id
    DOCKER_EE_VERSION = var.DOCKER_EE_VERSION
}

module "worker" {
    source = "./modules/worker"
    instancetype = var.instancetype
    sshkeypair = module.common.sshkeypair
    security_group_id = module.common.security_group_id
    subnet_id = module.common.subnet_id
    DOCKER_EE_VERSION = var.DOCKER_EE_VERSION
}