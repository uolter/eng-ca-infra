output "backend_bucket_name" {
  value = try(aws_s3_bucket.terraform_states[0].bucket, null)
}

output "dynamodb_lock_table" {
  value = try(aws_dynamodb_table.dynamodb-terraform-state-lock[0].name, null)
}

output "iac_role_arn" {
  value       = aws_iam_role.githubiac.arn
  description = "Role to use in github actions to build the infrastructure."
}