output "login_ecr" {
  value = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
}

output "docker_build_and_push" {
  value = <<EOT
docker build -t ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/vault:${var.vault_version} ../../vault/.
docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/vault:${var.vault_version}
EOT
}

output "list_running_ecs_service" {
  value = "ecs-cli ps --cluster ${aws_ecs_cluster.ecs_cluster.name} --desired-status RUNNING"
}

output "initialize_vault" {
  value = "curl -s -X PUT http://[VAULT_ADDR]:8200/v1/sys/init --data @../vault/init.json"
}
