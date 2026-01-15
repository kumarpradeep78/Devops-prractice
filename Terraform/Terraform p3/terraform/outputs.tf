

output "flask_ecr_repo" {
  value = aws_ecr_repository.flask.repository_url
}

output "express_ecr_repo" {
  value = aws_ecr_repository.express.repository_url
}
