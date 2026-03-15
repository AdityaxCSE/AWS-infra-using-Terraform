# Production-Grade AWS Infrastructure Provisioning using Terraform

This repository provisions a modular, production-grade AWS infrastructure using Terraform. It utilizes best practices by separating resources into reusable modules and organizing deployments by environments (e.g., `dev`).

## Architecture & Modules

The infrastructure is built using the following reusable modules located in the `modules/` directory:

- **VPC Module (`modules/vpc`)**: Provisions a Virtual Private Cloud (VPC), public and private subnets, and an Internet Gateway (IGW) for routing.
- **EC2 Module (`modules/ec2`)**: Provisions an EC2 server instance (`t3.micro` for Free Tier compatibility) inside the designated private subnet.
- **ALB Module (`modules/alb`)**: Core setup for an Application Load Balancer to distribute incoming traffic.

## Directory Structure

```text
.
├── backend.tf                 # Global backend configuration (S3 for remote state)
├── provider.tf                # Global AWS provider defaults
├── environments/
│   └── dev/                   # Dev environment workspace
│       ├── main.tf            # Instantiates the modules for the dev environment
│       ├── provider.tf        # Environment-specific provider (ap-south-1)
│       └── variables.tf       # Environment-specific variables
├── modules/
│   ├── alb/                   # ALB configuration module
│   ├── ec2/                   # EC2 instance module
│   └── vpc/                   # VPC and networking module
└── README.md
```

## Prerequisites

Before running this project, ensure you have the following ready:

1. **Terraform Installed**: version `1.x+` ([Download here](https://developer.hashicorp.com/terraform/downloads)).
2. **AWS CLI Configured**: Setup your AWS Identity and Access Management credentials with local configuration `aws configure`.
3. **S3 Bucket for State Backend**: The project is configured to use an Amazon S3 backend for tfstate files (`terraform-state-aditya-001`). Ensure this bucket exists in your AWS account or comment out the `backend` block in `backend.tf` to use a local state.

## Usage

To provision the infrastructure, you must execute the Terraform commands within the targeted environment directory (not the root directory).

1. **Navigate to the target environment:**
   ```bash
   cd environments/dev
   ```

2. **Initialize Terraform:**
   This command installs the required AWS provider and initializes the local Terraform modules.
   ```bash
   terraform init
   ```

3. **Preview the Execution Plan:**
   Generates a plan showing what resources Terraform will create, modify, or destroy.
   ```bash
   terraform plan
   ```

4. **Apply the Configuration:**
   Deploys the infrastructure to AWS. Type `yes` when prompted to confirm the changes.
   ```bash
   terraform apply
   ```

5. **Destroy the Infrastructure:**
   Once you are done testing, tear down the AWS resources to avoid incurring unnecessary charges.
   ```bash
   terraform destroy
   ```

## Important Notes & Fixes Applied

- **Region Specifics**: Testing and dev deployment have been set to `ap-south-1` (Mumbai).
- **Free Tier Adjustments**: The EC2 instance type was updated to `t3.micro` to ensure AWS Free Tier eligibility (since some AWS accounts block `t2.micro` instances in specific AZs).
- **Cross-Module References**: The EC2 instances are safely routed into your VPC because the VPC module cleanly exports its `private_subnet` outputs which are dynamically passed into the EC2 module.
