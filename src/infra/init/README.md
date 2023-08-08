## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | =5.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | =5.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.dynamodb-terraform-state-lock](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/dynamodb_table) | resource |
| [aws_iam_openid_connect_provider.github](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.githubiac](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.githubiac](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.terraform_states](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.terraform_states](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.terraform_states](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_public_access_block.terraform_states](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.terraform_states](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.admin_access](https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region (default is Milan) | `string` | `"eu-south-1"` | no |
| <a name="input_create_backend"></a> [create\_backend](#input\_create\_backend) | Crate S3 bucket and Dynamodb table to store the state file. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment. Possible values are: Dev, Uat, Prod | `string` | `"Uat"` | no |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | This github repository | `string` | `"https://github.com/pagopa/eng-ca.git"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform",<br>  "Environment": "Uat"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_bucket_name"></a> [backend\_bucket\_name](#output\_backend\_bucket\_name) | n/a |
| <a name="output_dynamodb_lock_table"></a> [dynamodb\_lock\_table](#output\_dynamodb\_lock\_table) | n/a |
| <a name="output_iac_role_arn"></a> [iac\_role\_arn](#output\_iac\_role\_arn) | Role to use in github actions to build the infrastructure. |
