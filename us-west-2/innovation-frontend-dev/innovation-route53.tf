module "cordachartexternal-recordset" {
  source        = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-alias-record"
  zone_id       = ["${var.route53_publiczone}", "${var.route53_privatezone}"]
  name          = "cordachartexternal.${var.env}.${var.domain_name}"
  type          = "A"
  alias_name    = "domo-tools-542333754.us-west-2.elb.amazonaws.com."
  alias_zone_id = "Z1H1FL5HABSF5"
}

module "cordachartinternal-recordset" {
  source        = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-alias-record"
  zone_id       = ["${var.route53_privatezone}"]
  name          = "cordachartinternal.${var.env}.${var.domain_name}"
  type          = "A"
  alias_name    = "domo-tools-542333754.us-west-2.elb.amazonaws.com."
  alias_zone_id = "Z1H1FL5HABSF5"
}

module "themescapemaster-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "themescapemaster.${var.env}.${var.domain_name}"
  type    = "A"
  records = ["10.236.107.192"]
  ttl     = "300"
}

module "dns-alb-CNAME" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_publiczone}", "${var.route53_privatezone}"]
  name    = "${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["${module.alb.alb_dns_name}"]
  ttl     = "300"
}

module "cassandracluster-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "cassandracluster.${var.env}.${var.domain_name}"
  type    = "A"
  records = ["10.236.104.53", "10.236.104.210", "10.236.105.99"]
  ttl     = "300"
}

module "t3search-customer-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "t3search.customer.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["t3search-snowflake.dev-innovation.com"]
  ttl     = "300"
}

module "t1-rds-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "dbhost.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["tier1-qa.csljrssfsvzi.us-west-2.rds.amazonaws.com"]
  ttl     = "300"
}

module "docdel-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "docdel.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["devdocdelivery.dev-innovation.com"]
  ttl     = "86400"
}

module "t3search-exporter-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "t3search.exporter.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["t3search-snowflake.dev-innovation.com"]
  ttl     = "300"
}

module "t3search-feeder-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "t3search.feeder.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["t3search-snowflake.dev-innovation.com"]
  ttl     = "300"
}

module "imaphost-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "imaphost.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["tshuspaphimbx01.erf.thomson.com"]
  ttl     = "300"
}

module "patents-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "patents.${var.env}.${var.domain_name}"
  type    = "A"
  records = ["10.237.162.17"]
  ttl     = "300"
}

module "t3search-scheduler-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "t3search.scheduler.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["t3search-snowflake.dev-innovation.com"]
  ttl     = "300"
}

module "steam-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "steam.${var.env}.${var.domain_name}"
  type    = "A"
  records = ["10.204.33.120"]
  ttl     = "300"
}

module "systran-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "systran.${var.env}.${var.domain_name}"
  type    = "A"
  records = ["10.236.111.119"]
  ttl     = "300"
}

module "t3jp-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "t3jp.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["t3search-snowflake.dev-innovation.com"]
  ttl     = "300"
}

module "t3search-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "t3search.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["t3search-snowflake.dev-innovation.com"]
  ttl     = "300"
}

module "tcache-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "tcache.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["customfields-customdata.csljrssfsvzi.us-west-2.rds.amazonaws.com"]
  ttl     = "300"
}

module "wok-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "wok.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["mws-internal.wos-non-prod.oneplatform.build"]
  ttl     = "300"
}

module "graylogger-recordset" {
  source  = "git@github.com:ManoranjanMadhugiri/innovation-terraform-modules.git//innovation-route53/innovation-route53-record"
  zone_id = ["${var.route53_privatezone}"]
  name    = "graylogger.${var.region}.${var.env}.${var.domain_name}"
  type    = "CNAME"
  records = ["graylogger.us-west-2.dev.oneplatform.build"]
  ttl     = "300"
}
