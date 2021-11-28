provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
     bucket         = "trf-bkt-4-backend"
     key            = "prod/services/webserver-cluster/terraform.tfstate"
     region         = "us-east-2"
     dynamodb_table = "trf-tbl-4-backend"
     encrypt        = true
  }
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  # TODO: try use versioned modules
  # Above declared module is included in the same repo. Envs can rely on different version of modules. To allow it those
  # common parts (modules) must be in another repo, then (specified version) imported into terraform live env backends.
  #
  # Example: (reads from tag v0.1.1)
  # source = "github.com/{username}/{reponame}/modules/services/webserver-cluster?ref=v0.1.1"
  #


  cluster_name           = var.cluster_name
  db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key    = var.db_remote_state_key

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 10
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 4
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 3
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

