resource "aws_ecr_repository" "flask" {
  name = "flask-backend"
}

resource "aws_ecr_repository" "express" {
  name = "express-frontend"
}
