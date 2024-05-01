DevOps Automation for Django Application Deployment

This project showcases an end-to-end DevOps pipeline designed to automate the deployment process of a Django application on Amazon EKS (Elastic Kubernetes Service). It utilizes a combination of Terraform for infrastructure provisioning, Ansible for configuration management, Docker for containerization, Kubernetes for orchestration, and Jenkins for CI/CD automation.

Technologies Used:
Terraform: Infrastructure provisioning tool for defining and managing infrastructure as code.
Ansible: Configuration management tool used for setting up and configuring Jenkins on EC2 instances.
Docker: Containerization platform utilized for packaging the Django application and its dependencies.
Kubernetes: Container orchestration system for automating the deployment, scaling, and management of containerized applications.
Jenkins: Automation server employed for orchestrating the CI/CD pipeline and automating the build, test, and deployment processes.
Project Steps:
Infrastructure Provisioning with Terraform:
Utilized Terraform to provision an Amazon EKS cluster with two node groups.
Set up Amazon ECR (Elastic Container Registry) for storing Docker images.
Configured Amazon RDS (Relational Database Service) as the backend database for the Django application.
Launched an EC2 instance to host the Jenkins CI/CD server.
Jenkins Setup with Ansible:
Created Ansible playbooks to automate the installation and configuration of Jenkins on the EC2 instance.
Installed required packages and dependencies for Jenkins operation.
Dockerization of Django App:
Developed Dockerfile to containerize the Django application, ensuring portability and consistency across environments.
Built Docker images for the Django application and pushed them to Amazon ECR for storage and distribution.
Kubernetes Deployment:
Defined Kubernetes deployment YAML files specifying the desired state of the Dockerized Django application.
Configured a Kubernetes service for load balancing and routing traffic to the application pods.
Jenkins Pipeline Configuration:
Implemented Jenkins pipeline to automate the build, test, and deployment processes of the Django application.
Integrated Jenkins with Amazon ECR to facilitate the seamless build and push of Docker images.
Orchestrated the deployment of the Django application on the Amazon EKS cluster using Kubernetes manifests.
Outcome:
Achieved a fully automated CI/CD pipeline for the Django application, resulting in reduced deployment times and improved efficiency.
Ensured scalability and reliability of the application through containerization and Kubernetes orchestration.
Enhanced maintainability and reproducibility of the deployment process with Infrastructure as Code (IaC) principles using Terraform and Ansible.
