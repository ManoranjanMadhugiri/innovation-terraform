module "innovation-themescape_emr_Master_security_group" {
  source   = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups"
  sec_name = "ElasticMapReduce-Master-Private"
  env      = "${var.env}"
  vpc_id   = "${var.vpc_id}"
}

module "innovation-themescape-emr-inbound_infra_bastion" {
  source = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules/inbound_rules"
  source_security_groups = ["${var.bastion_security_group}"]
  to_ports               = [8080, 19888, 8042,20888,22,8088]
  from_ports            = [8080, 19888, 8042,20888,22,8088]
  security_group_id      = "${module.innovation-themescape_emr_Master_security_group.security_group_id}"
  description            = "themescape_emr_Master_security_group"
}

module "innovation-themescape-emr-inbound" {
  source = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules/inbound_rules"
  source_security_groups = ["${var.bastion_security_group}","${module.innovation-themescape_emr_service_access_security_group.security_group_id}"]
  to_ports              = [8080, 8443]
  from_ports           = [8080, 8443]
  security_group_id      = "${module.innovation-themescape_emr_Master_security_group.security_group_id}"
  description            = "themescape_emr_Master_security_group"
}


module "innovation-themescape_emr_slave_security_group" {
  source   = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups"
  sec_name = "ElasticMapReduce-Slave-Private"
  env      = "${var.env}"
  vpc_id   = "${var.vpc_id}"
}

module "innovation-themescape-emr_slave_security_group-inbound" {
  source = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules/inbound_rules"
  source_security_groups = ["${var.bastion_security_group}","${module.innovation-themescape_emr_service_access_security_group.security_group_id}"]
  to_ports               = [8042, 8443 ,22]
  from_ports             = [8042, 8443 ,22]
  security_group_id      = "${module.innovation-themescape_emr_slave_security_group.security_group_id}"
  description            = "themescape_slave_security_group"
}

module "innovation-themescape_emr_service_access_security_group" {
  source   = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups"
  sec_name = "ElasticMapReduce-ServiceAccess"
  env      = "${var.env}"
  vpc_id   = "${var.vpc_id}"
}

module "innovation-themescape_emr_service_access_security_group_outbound"{
  source = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules/outbound_rules"
  source_security_groups = ["${module.innovation-themescape_emr_Master_security_group.security_group_id}","${module.innovation-themescape_emr_slave_security_group.security_group_id}"]
  to_ports               = [8443, 8443 ]
  from_ports             = [8443, 8443 ]
  security_group_id      = "${module.innovation-themescape_emr_service_access_security_group.security_group_id}"
  description            = "themescape_service_access_security_group"
}

module "themescape_emr"{
  source = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-themescape-emr"
  env = "${var.env}"
  region = "${var.region}"
  emr_version = "emr-5.8.0"
  emr_type = "Hadoop"
  subnet_id = "${element(var.private_subnet_ids,0)}"
  emr_managed_master_security_group = "${module.innovation-themescape_emr_Master_security_group.security_group_id}"
  emr_managed_slave_security_group = "${module.innovation-themescape_emr_slave_security_group.security_group_id}"
  service_access_security_group = "${module.innovation-themescape_emr_service_access_security_group.security_group_id}"
}
