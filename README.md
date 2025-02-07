# game_highlight_processor_terraform
This project builds on our previous NCAA game highlight processing pipeline (link below), which used a deployment script. We're now implementing a full end-to-end deployment using Terraform. This Infrastructure-as-Code  approach allows us to manage AWS resources consistently and scalably, automating video ingestion, processing, and delivery.

https://dev.to/gbenga700/streamlining-ncaa-game-highlights-with-rapidapi-docker-and-aws-mediaconvert-22li

Technical Diagram

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/1r7izapstaqhg7gez9e9.png)

**Prerequisites**
Before we get started, ensure you have the following:
1. **RapidAPI Account**: Sign up for a RapidAPI account and subscribe to an API that provides NCAA game highlights.
2. **AWS Account**: AWS access with the required permission to access the necessary services.
3. **Docker Installed**: Install Docker on your system to run the containerized workflow.
4. **Terraform Installed**: Ensure Terraform is installed for infrastructure deployment.
5. **Basic CLI Knowledge**: Familiarity with using command-line tools for API requests, AWS configurations, and Terraform commands.

**Tech Stack**

- Python
- AWS ECR, ECS & Elemental MediaConvert
- Docker
- Terraform

**Step 1: Clone the project Repository**

By cloning the project Repository, we'll have access to the application codes and terraform configurations needed for our deployment process.

Clone Repository: Use the 

```
git clone
```
 command to clone the Terraform code repository to your local machine. Ensure that you have Git installed and configured on your system.

https://github.com/OjoOluwagbenga700/ncaa_game_highlight_terraform.git

Navigate to Repository: cd ncaa_game_highlight_terraform 

**Step 2: Running Terraform Commands**
1. Initialize Terraform: Run 

```
terraform init
```
 to initialize the Terraform working directory and download the necessary plugins.


2. Plan the Deployment: Run  

```
terraform plan
```
 to preview the resources that Terraform will create.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/34ofnidxa7h4wsiwd92l.png)


3. Apply the Configuration: Run 

```
terraform apply –auto-approve
```
 to deploy the infrastructure.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/c86qwwlwpsj2jbk7el3k.png)

**Step 3: Verify Application deployment by confirming resources deployed on AWS**

check the documentation link for the images : [](https://dev.to/gbenga700/game-highlights-processor-ecr-ecs-aws-elemental-mediaconvert-docker-terraform-25cc)
