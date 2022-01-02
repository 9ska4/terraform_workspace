output "all_arns_from_example_1" {
  value = aws_iam_user.example_1[*].arn
}

output "all_users_from_example_2" {
  value = values(aws_iam_user.example_2)[*].arn
}

#
#output "all_users_from_example_3" {
#  value = aws_iam_user.example_3
#}
