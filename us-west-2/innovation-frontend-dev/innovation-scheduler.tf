module "scheduler_targetgroup" {
  source            = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-target-groups"
  name              = "scheduler"
  env               = "${var.env}"
  target_port       = 8080
  vpc_id            = "${var.vpc_id}"
  health_check_path = "/tip-innovation/healthCheck.html"
}

module "scheduler_listener-rule" {
  source         = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-listener-rule"
  listener_arn   = "${module.innov-alb-listener_http.listener_arn}"
  priority       = 5
  alb_target_arn = "${module.scheduler_targetgroup.alb_target_arn}"
  route_path     = ["/tip-innovation/schedule/*"]
}

module "scheduler_listener-rule_https" {
  source         = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-listener-rule"
  listener_arn   = "${module.innov-alb-listener_https.listener_arn}"
  priority       = 5
  alb_target_arn = "${module.scheduler_targetgroup.alb_target_arn}"
  route_path     = ["/tip-innovation/schedule/*"]
}

# module "scheduler_launch_config" {
#   source               = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-launchconfig"
#   name                 = "scheduler"
#   env                  = "${var.env}"
#   instance_type        = "t2.large"
#   security_groups      = ["${module.innovation-exporter-security_group.security_group_id}", "${var.bastion_security_group}"]
#   keyname              = "${module.innovation-keypair.keypair_name}"
#   service_name         = "scheduler"
#   domain_name          = "${var.domain_name}"
#   dynomite_clusterName = "${var.dynomite_clusterName}"
#   node_count           = 1
# }
#
# module "scheduler_auto_scaling_group" {
#   source             = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-asg"
#   name               = "scheduler"
#   env                = "${var.env}"
#   private_subnet_ids = "${var.private_subnet_ids}"
#   launch_conf        = "${module.scheduler_launch_config.launch_conf}"
#   min_size           = 1
#   max_size           = 1
#   target_group_arns  = ["${module.scheduler_targetgroup.alb_target_arn}"]
# }
