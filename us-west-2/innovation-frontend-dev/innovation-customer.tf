module "customer_targetgroup" {
  source            = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-target-groups"
  name              = "customer"
  env               = "${var.env}"
  target_port       = 80
  vpc_id            = "${var.vpc_id}"
  health_check_path = "/tip-innovation/healthCheck.html"
  add_tags          = "${var.default_tags}"
}

# module "customer_launch_config" {
#   source               = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-launchconfig"
#   name                 = "customer"
#   env                  = "${var.env}"
#   instance_type        = "t2.large"
#   security_groups      = ["${module.innovation-customer-security_group.security_group_id}", "${var.bastion_security_group}"]
#   keyname              = "${module.innovation-keypair.keypair_name}"
#   service_name         = "customer"
#   domain_name          = "${var.domain_name}"
#   dynomite_clusterName = "${var.dynomite_clusterName}"
#   node_count           = 1
# }

module "customer_listener_rule" {
  source         = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-listener-rule"
  listener_arn   = "${module.innov-alb-listener_http.listener_arn}"
  priority       = 3
  alb_target_arn = "${module.customer_targetgroup.alb_target_arn}"
  route_path     = ["/tip-innovation/remoting/*"]
}

module "customer_listener_rule_https" {
  source         = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-listener-rule"
  listener_arn   = "${module.innov-alb-listener_https.listener_arn}"
  priority       = 3
  alb_target_arn = "${module.customer_targetgroup.alb_target_arn}"
  route_path     = ["/tip-innovation/remoting/*"]
}

# module "customer_auto_scaling_group" {
#   source             = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-asg"
#   name               = "customer"
#   env                = "${var.env}"
#   private_subnet_ids = "${var.private_subnet_ids}"
#   launch_conf        = "${module.customer_launch_config.launch_conf}"
#   min_size           = 1
#   max_size           = 1
#   target_group_arns  = ["${module.customer_targetgroup.alb_target_arn}"]
#
#   extra_tags = [{
#     "key"                 = "serviceGroup"
#     "value"               = "${var.env}:customer"
#     "propagate_at_launch" = true
#   }]
# }

# Adding customer_security_group to dynomite_manager_security_group
module "dynomite_manager-security_group_rule" {
  source                 = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules/inbound_rules"
  source_security_groups = ["${module.innovation-customer-security_group.security_group_id}"]
  to_ports               = [8080, 8101, 8102]
  from_ports             = [8080, 8101, 8101]
  security_group_id      = "${var.dynomite_manager_security_group}"
  description            = "customer_security_group"
}

module "systran-security_group_rule" {
  source                 = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-security-groups/innovation-frontend-security-groups-rules/inbound_rules"
  source_security_groups = ["${module.innovation-customer-security_group.security_group_id}"]
  to_ports               = [8903, 8904]
  from_ports             = [8903, 8904]
  security_group_id      = "${var.systran_security_group}"
  description            = "customer_security_group"
}
