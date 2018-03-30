module "alb" {
  name              = "di-alb"
  source            = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-alb"
  public_subnet_ids = "${var.public_subnet_ids}"
  security_groups   = ["${var.eelb_security_group}", "${var.bastion_security_group}"]
  env               = "${var.env}"
  region            = "${var.region}"
  idle_timeout      = 300
  default_tags      = "${var.default_tags}"
}

module "innov-alb-listener_http" {
  source           = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-alb-listener"
  alb_arn          = "${module.alb.alb_arn}"
  target_group_arn = "${module.customer_targetgroup.alb_target_arn}"
}

module "innov-alb-listener_https" {
  source           = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-frontend-alb-listener"
  port             = 443
  protocol         = "HTTPS"
  alb_arn          = "${module.alb.alb_arn}"
  target_group_arn = "${module.customer_targetgroup.alb_target_arn}"
  certificate_arn  = "${var.domain_name == "dev-innovation.com" ? "arn:aws:acm:us-west-2:687890756020:certificate/d34e745d-03ea-48f7-89c4-208225f68b51":
                        var.domain_name =="derwentinnovation.com" ? "arn:aws:acm:us-west-2:687890756020:certificate/3d3b38a1-1918-424e-8202-786c70f8aac9":""}"

  ssl_policy = "ELBSecurityPolicy-TLS-1-2-2017-01"
}
