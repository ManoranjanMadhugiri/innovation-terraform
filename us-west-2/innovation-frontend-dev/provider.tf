provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "${var.AWS_REGION}"
}

terraform {
  backend "s3" {
    bucket = "clarivate-innovate-dev-us-west-2-di-terraform-state"
    key    = "prod/derwentinnovation/terraform.tfstate"
    region = "us-west-2"

    //dynamodb_table="${aws_dynamodb_table.innovation-dev-infrastructure_statelock.id}"
  }
}

#
# resource "aws_dynamodb_table" "innovation-infrastructure_statelock" {
#   name           = "${var.dynamodb_table_name}"
#   read_capacity  = 5
#   write_capacity = 5
#   hash_key       = "LockID"
#
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
#
#   tags {
#     name = "state lock table"
#   }
# }

