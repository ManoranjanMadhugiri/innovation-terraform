vpc_id = "vpc-c2447ca5"
AWS_ACCESS_KEY=""
AWS_SECRET_KEY=""
env="prod"
region="us-west-2"
eelb_security_group= "sg-07b3a97c"
bastion_security_group= "sg-35f76b4f"
private_subnet_ids = ["subnet-4c325d05", "subnet-e7316580","subnet-d4e31c8f"]
public_subnet_ids = ["subnet-3de71866", "subnet-fd34609a","subnet-e73659ae"]
cassandra_security_group="sg-f192708d"
dynomite_manager_security_group="sg-3cb91640"
emr_managed_master_security_group="sg-c1c3f1bb"
systran_security_group="sg-4c65f630"
dynamodb_table_name="innovation-infrastructure_statelock"
domain_name = "dev-innovation.com"
dynomite_clusterName = "themescape-dynomite-1p-d0snapshot-r0-v1"
route53_publiczone = "Z1DF6HZN35DKBL"
route53_privatezone = "Z8SG6XL97KAET"
default_tags{
  "app_name" = "Derwent innovation"
  "created_by" = "innovation-terraform"
}
