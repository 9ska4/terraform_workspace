provider "aws" {
  region = "us-east-2"
}

# declare 3 users based incrementation
resource "aws_iam_user" "example_1" {
  count = 3
  name  = "${var.user_name_prefix}.${count.index}"
}

# declare 3 users based on list (for_each way)
resource "aws_iam_user" "example_2" {
  for_each = toset(var.user_names_list)
  name     = each.value
}

