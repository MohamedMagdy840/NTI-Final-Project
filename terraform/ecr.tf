#Create ecr to store my images on it
resource "aws_ecr_repository" "ecr_repository" {
  name = "ecr_repository"
}

#To get repository name
output "ecr_repository_name" {
  description = "The name of the created Amazon ECR repository"
  value       = aws_ecr_repository.ecr_repository.name

}

#To get DNS(URL) of my repository
output "ecr_repository_url" {
  description = "The URL of the Amazon ECR repository"
  value       = aws_ecr_repository.ecr_repository.repository_url

}

resource "local_file" "ecr_url" {
  filename = "ecr_url"
  content = aws_ecr_repository.ecr_repository.repository_url
}

# aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 590183792206.dkr.ecr.us-east-1.amazonaws.com/ecr_repository
# docker tag django:latest 590183792206.dkr.ecr.us-east-1.amazonaws.com/ecr_repository:latest
# docker push 590183792206.dkr.ecr.us-east-1.amazonaws.com/ecr_repository:latest
