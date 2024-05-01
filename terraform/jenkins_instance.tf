#this ec2 not part of eks cluster nodes if i need it when any problem occur
#to be part of my eks cluster with configuration to do it
#we will use ansible to install and configure jenkins in this ec2 instance

resource "aws_instance" "jenkins_instance" {
  ami                         = "ami-080e1f13689e07408"
  instance_type               = "t3.medium"
  subnet_id                   = aws_subnet.public_subnet_01.id
  key_name                    = #your key pair "here" 
  associate_public_ip_address = true
  root_block_device {
    volume_size = 15
  }


  tags = {
    Name = "jenkins_instance"

  }
  security_groups = [aws_security_group.jenkins_instance_sg.id]

  iam_instance_profile = aws_iam_instance_profile.jenkins_ecr_profile.name

}

resource "local_file" "public_ip_file" {
  filename = "inventory"
  content  = aws_instance.jenkins_instance.public_ip
}





resource "aws_security_group" "jenkins_instance_sg" {
  name        = "jenkins_instance_sg"
  description = "security group for jenkins instance"
  vpc_id      = aws_vpc.node_vpc.id



  # Define ingress rules
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }


  # Define egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IAM Policy for ECR
resource "aws_iam_policy" "jenkins_ecr_policy" {
  name        = "ECRFullAccessPolicy"
  description = "Allows full access to ECR"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ecr:*"
        Resource = "*"
      }
    ]
  })
}

# IAM Role for EC2
resource "aws_iam_role" "jenkins_ecr_role" {
  name = "EC2ECRFullAccessRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach IAM Policy to Role
resource "aws_iam_role_policy_attachment" "ec2_ecr_attachment" {
  role       = aws_iam_role.jenkins_ecr_role.name
  policy_arn = aws_iam_policy.jenkins_ecr_policy.arn
}

resource "aws_iam_instance_profile" "jenkins_ecr_profile" {
  name = "jenkins-ecr-profile"
  role = aws_iam_role.jenkins_ecr_role.name
}
