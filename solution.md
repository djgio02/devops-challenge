# DevOps Challenge:

In this challenge will be provisioned a Kubernetes cluster using AWS EKS with eksctl, which is a simple cli to create k8s clusters on AWS EKS. 
Officially supported by AWS: https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html

## Prerequisites

This challenge will make the following assumptions:
- You have AWS CLI already installed and configured in your system, if not please follow: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html
- You have kubectl already installed in your system, if not please follow: https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
- You have Terraform installed in your system, if not please follow: https://www.terraform.io/downloads.html
- You have eksctl installed and an AWS user with sufficient privilege in AWS CLI to use it, if not please follow: https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html

## What are we going to build?

This is a simple golang application that is listening on port 80 for request, also manages to connect to an RDS DB service using a Kubernetes secret and externalName service from the cluster. The application is quite simple and is design with 3 replicas and a service that exposes the application to the world, behind a load balancer that is provisioned with the service by the EKS cluster. This design was considered to provide HA to the service and the infrastructure as well. With managed services by AWS like EKS and RDS, we pass some maintenance tasks to them, like underlying upgrades, read replicas, and so on, that way our application is more scalable.

##include diagram

![architecture in AWS](https://drive.google.com/file/d/1SRIBn3V5KKGzQvhXeNiHUh9MhFAVXM70/view?usp=sharing)

Application is live in this link in my own AWS infrastructure: https://koho.gigacorp.link/koho


### Building & Testing

After clearing all the prerequisites, the first thing to do is a terraform init to initialize the modules and the local backend.
Then we proceed with the terraform plan and terraform apply commands in order to get the networking part done for the cluster.
This process could take up to 18 minutes.
After getting the output from the terraform apply, please note the results in your AWS infrastructure and the output in the terminal.
Next, we follow with the cluster scripts that were designed to automate the EKS cluster provision using eksctl tool. Start by running the cluster-install.sh file and you will see the output for the cluster creation in AWS.
This process could take up to 25 minutes.
Later we get to run the cluster-prep.sh file which will help us put some data into the RDS Postgres DB. Data example to try is included in the script as comments. If you don't want to insert any data into the RDS DB, just close the container running Postgres by typing \q .
Finally, we can proceed with the deployment of the test application using the deploy-app.sh file or by running the kubectl commands on the hellogo-dep-svc.yaml.
This deployment will also provision a load balancer defined in the service that will put the DNS name in the terminal.
Get this link into the browser and you will be having a fully automated EKS and RDS environment to test other applications.
Last is to clean up the infra using the clean-up.sh file, this will destroy the cluster first and later the remaining AWS resources.

-- 
 
 
Giomar Garcia - AWS Solution Architect
8093034203
