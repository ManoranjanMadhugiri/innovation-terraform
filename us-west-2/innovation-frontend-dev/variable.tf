variable "vpc_id" {
  default = ""
}

variable "AWS_REGION" {
  default = "us-west-2"
}

variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "env" {}

variable "region" {}

variable "eelb_security_group" {
  default = ""
}

variable "bastion_security_group" {
  default = ""
}

variable "private_subnet_ids" {
  type = "list"
}

variable "public_subnet_ids" {
  type = "list"
}

variable "cassandra_security_group" {
  default = ""
}

variable "dynomite_manager_security_group" {
  default = ""
}

variable "emr_managed_master_security_group" {
  default = ""
}

variable "dynamodb_table_name" {
  default = ""
}

variable "route53_publiczone" {
  default = ""
}

variable "route53_privatezone" {
  default = ""
}

variable "default_tags" {
  type = "map"
}

variable "domain_name" {
  default = ""
}

variable "dynomite_clusterName" {
  default = ""
}

variable "systran_security_group" {
  default = ""
}
