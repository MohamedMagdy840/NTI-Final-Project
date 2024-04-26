pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE_NAME = "django"
        ECR_REPO_URL = "123456789012.dkr.ecr.us-east-1.amazonaws.com/your-repo"
        AWS_DEFAULT_REGION = "us-east-1"
        K8S_YAML_FILE = "django.yml"
        DOCKER_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
        AWS_ACCESS_KEY_ID = credentials('your-aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('your-aws-secret-access-key')
        EKS_CLUSTER_NAME = 'your-eks-cluster-name'
    }

    stages {
        stage('Configure AWS CLI') {
            steps {
                script {
                    sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
                    sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
                    sh "aws configure set region ${AWS_DEFAULT_REGION}"
                }
            }
        }
        
        stage('Update kubeconfig') {
            steps {
                script {
                    sh "aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME} --region ${AWS_DEFAULT_REGION}"
                }
            }
        }
        
        stage('Build, Tag, and Push Docker image to ECR') {
            steps {
                script {
                    sh '''
                    DOCKER_IMAGE_NAME="${DOCKER_IMAGE_NAME}"
                    ECR_REPO_URL="${ECR_REPO_URL}"
                    AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION}"
                    K8S_YAML_FILE="${K8S_YAML_FILE}"
                    DOCKER_TAG="${DOCKER_TAG}"

                    # Build Docker image
                    docker build -t ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} .

                    # Tag Docker image
                    docker tag ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} ${ECR_REPO_URL}:${BUILD_NUMBER}

                    # Authenticate Docker with ECR
                    aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URL}

                    # Push Docker image to ECR
                    docker push ${ECR_REPO_URL}:${BUILD_NUMBER}

                    # Update Kubernetes YAML file with ECR repository URL
                    sed -i "s#image:.*#image: ${ECR_REPO_URL}:${BUILD_NUMBER}#" ${K8S_YAML_FILE}
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh "kubectl apply -f ${K8S_YAML_FILE}"
                }
            }
        }
        
        // Add more stages for your build/test/deploy process
    }
}

















// pipeline {
//     agent any
    
//     environment {
//         DOCKER_IMAGE_NAME = "django"
//         ECR_REPO_URL = "123456789012.dkr.ecr.us-west-2.amazonaws.com/your-repo"
//         AWS_DEFAULT_REGION = "us-east-1"
//         K8S_YAML_FILE = "django.yml"
//         DOCKER_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
//     }

//     stages {
//         stage('Build, Tag, and Push Docker image to ECR') {
//             steps {
//                 script {
//                     sh '''
//                     DOCKER_IMAGE_NAME="${DOCKER_IMAGE_NAME}"
//                     ECR_REPO_URL="${ECR_REPO_URL}"
//                     AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION}"
//                     K8S_YAML_FILE="${K8S_YAML_FILE}"
//                     DOCKER_TAG="${DOCKER_TAG}"

//                     # Build Docker image
//                     docker build -t ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} .

//                     # Tag Docker image
//                     docker tag ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} ${ECR_REPO_URL}:${BUILD_NUMBER}

//                     # Authenticate Docker with ECR
//                     aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URL}

//                     # Push Docker image to ECR
//                     docker push ${ECR_REPO_URL}:${BUILD_NUMBER}

//                     # Update Kubernetes YAML file with ECR repository URL
//                     sed -i "s#image:.*#image: ${ECR_REPO_URL}:${BUILD_NUMBER}#" ${K8S_YAML_FILE}
//                     '''
//                 }
//             }
//         }

//         stage('Deploy to Kubernetes') {
//             steps {
//                 script {
//                     sh "kubectl apply -f ${K8S_YAML_FILE}"
//                 }
//             }
//         }
//     }
// }
