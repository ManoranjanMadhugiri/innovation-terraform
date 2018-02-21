module "frontapp_targetgroup" {
  source            = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-target-groups"
  name              = "frontapp"
  env               = "${var.env}"
  target_port       = 8080
  vpc_id            = "${var.vpc_id}"
  health_check_path = "/frontapp/healthCheck.html"
}

module "frontapp_listener-rule" {
  source         = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-listener-rule"
  listener_arn   = "${module.innov-alb-listener_http.listener_arn}"
  priority       = 6
  alb_target_arn = "${module.frontapp_targetgroup.alb_target_arn}"
  route_path     = ["/frontapp/*"]
}

module "frontapp_listener-rule_https" {
  source         = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-listener-rule"
  listener_arn   = "${module.innov-alb-listener_https.listener_arn}"
  priority       = 6
  alb_target_arn = "${module.frontapp_targetgroup.alb_target_arn}"
  route_path     = ["/frontapp/*"]
}

module "frontapp_launch_config" {
  source               = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-launchconfig"
  name                 = "frontapp"
  env                  = "${var.env}"
  instance_type        = "t2.large"
  iam_instance_profile = "s3-derwentthemescape"
  security_groups      = ["${module.innovation-frontapp-security_group.security_group_id}", "${var.bastion_security_group}"]
  keyname              = "${module.innovation-keypair.keypair_name}"
  service_name         = "frontapp"
  domain_name          = "${var.domain_name}"
  dynomite_clusterName = "${var.dynomite_clusterName}"
  node_count           = 1
}

module "frontapp_auto_scaling_group" {
  source             = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-asg"
  name               = "frontapp"
  env                = "${var.env}"
  private_subnet_ids = "${var.private_subnet_ids}"
  launch_conf        = "${module.frontapp_launch_config.launch_conf}"
  min_size           = 1
  max_size           = 1
  target_group_arns  = ["${module.frontapp_targetgroup.alb_target_arn}"]
}

# Adding frontapp security_group to cassandra cluster security group
module "cassandra-security_group_rule" {
  source                 = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules"
  source_security_groups = ["${module.innovation-frontapp-security_group.security_group_id}"]
  to_ports               = [9160, 9042]
  from_ports             = [9160, 9042]
  security_group_id      = "${var.cassandra_security_group}"
  description            = "frontapp_security_group"
}

# Adding frontapp security_group to EMR master security group
module "EMR-security_group_rule" {
  source                 = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules"
  source_security_groups = ["${module.innovation-frontapp-security_group.security_group_id}"]
  to_ports               = [8080]
  from_ports             = [8080]
  security_group_id      = "${var.emr_managed_master_security_group}"
  description            = "frontapp_security_group"
}
