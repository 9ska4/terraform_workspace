/*
steps:
1. comment out `terraform.backend` block
2. run: terraform init
3. run: terraform apply
4. bring back `terraform.backend` block
5. run: terraform init
5. run: terraform apply
6. now terraform backend will be available in AWS(s3 + dynamo_table)
*/
terraform {
  backend "s3" {
    bucket = "bucket374terraform" // variable.tf.bucket_name
    key = "workspace-example/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "table374terraform" // variable.tf.table_name
    encrypt = true
  }
}