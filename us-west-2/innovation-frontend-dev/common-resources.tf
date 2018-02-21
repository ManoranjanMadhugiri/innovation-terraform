module "s3" {
  source = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-s3"
  env    = "${var.env}"
  region = "${var.region}"
}

# module "innovation-keypair" {
#   source   = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-keypair"
#   key_name = "innovation-key-${var.env}"
# }

module "innovation-exporter-security_group" {
  source   = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups"
  sec_name = "exporter-scg"
  env      = "${var.env}"
  vpc_id   = "${var.vpc_id}"
}

module "innovation-exporter-security_group_rule" {
  source                 = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules"
  source_security_groups = ["${var.eelb_security_group}"]
  to_ports               = [8080, 9088, 8081]
  from_ports             = [8080, 9088, 8081]
  security_group_id      = "${module.innovation-exporter-security_group.security_group_id}"
  description            = "exporter_security_group"
}

module "innovation-customer-security_group" {
  source   = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups"
  sec_name = "customer-scg"
  env      = "${var.env}"
  vpc_id   = "${var.vpc_id}"
}

module "innovation-customer-security_group_rule" {
  source                 = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules"
  source_security_groups = ["${var.eelb_security_group}", "${module.innovation-exporter-security_group.security_group_id}"]
  to_ports               = [81, 81, 80, 80, 9000, 9000, 8999, 8999]
  from_ports             = [81, 81, 80, 80, 9000, 9000, 8999, 8999]
  security_group_id      = "${module.innovation-customer-security_group.security_group_id}"
  description            = "customer_security_group"
}

module "innovation-frontapp-security_group" {
  source   = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups"
  sec_name = "frontapp-scg"
  env      = "${var.env}"
  vpc_id   = "${var.vpc_id}"
}

module "innovation-frontapp-security_group_rule" {
  source                 = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules"
  source_security_groups = ["${var.eelb_security_group}"]
  to_ports               = [8080]
  from_ports             = [8080]
  security_group_id      = "${module.innovation-frontapp-security_group.security_group_id}"
  description            = "frontapp_security_group"
}
