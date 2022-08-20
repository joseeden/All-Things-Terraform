
----------------------------------------------

<!-- TOC -->

- [Terraform Basics](#terraform-basics)
    - [Provisioning Workflow](#provisioning-workflow)
    - [Public Module registry](#public-module-registry)
    - [Providers](#providers)
    - [Terraform Root Module](#terraform-root-module)
    - [Terraform Workspaces](#terraform-workspaces)
    - [The main file - main.tf](#the-main-file---maintf)
    - [The variables files - variables.tf](#the-variables-files---variablestf)
    - [terraform.tfvars vs variables.tf](#terraformtfvars-vs-variablestf)
    - [The outputs file - outputs.tf](#the-outputs-file---outputstf)
    - [Terraform State](#terraform-state)
    - [Terraform State - Remote State](#terraform-state---remote-state)
    - [Terraform State - Locking](#terraform-state---locking)
    - [Authentication](#authentication)
    - [Setup Local Environment](#setup-local-environment)
    - [Install Terraform](#install-terraform)
    - [Terraform CLI](#terraform-cli)
    - [Terraform HCL Language](#terraform-hcl-language)
- [Lab 01: Build a Dev Environment with Terraform and AWS](#lab-01-build-a-dev-environment-with-terraform-and-aws)
    - [Introduction](#introduction)
    - [Authentication](#authentication)
    - [Setup Local Environment](#setup-local-environment)
    - [Install Terraform](#install-terraform)
    - [Configure AWS Provider](#configure-aws-provider)
    - [Provision a VPC](#provision-a-vpc)
    - [Terraform State](#terraform-state)
    - [Terraform Destroy](#terraform-destroy)
    - [Deploy a Public Subnet](#deploy-a-public-subnet)
    - [Deploy an Internet Gateway](#deploy-an-internet-gateway)
    - [Terraform Format](#terraform-format)
    - [Create the Route table](#create-the-route-table)
    - [Create the Route Table Association](#create-the-route-table-association)
    - [Create the Security Group](#create-the-security-group)
    - [Get the AMI Datasource](#get-the-ami-datasource)
    - [Create a Keypair](#create-a-keypair)
    - [Deploy the EC2 Instance](#deploy-the-ec2-instance)
    - [Bootstrap EC2 with Userdata](#bootstrap-ec2-with-userdata)
    - [Create SSH Config Scripts - Templatefile](#create-ssh-config-scripts---templatefile)
    - [Configure VSCode with Provisioner](#configure-vscode-with-provisioner)
    - [Variables and their precedence](#variables-and-their-precedence)
    - [Outputs](#outputs)
    - [References:](#references)
- [Lab 02: DEV Environment with SQS and Lambda](#lab-02-dev-environment-with-sqs-and-lambda)
    - [Introduction](#introduction)
    - [Authentication](#authentication)
    - [Setup Local Environment](#setup-local-environment)
    - [Install Terraform](#install-terraform)
    - [Lambda function](#lambda-function)
    - [Create the Provider file](#create-the-provider-file)
    - [Create the Variables file](#create-the-variables-file)
    - [Create the main.tf file and run](#create-the-maintf-file-and-run)
    - [Test the Lambda function](#test-the-lambda-function)
    - [Modify the Lambda Handler Name](#modify-the-lambda-handler-name)
    - [Create the SQS Queues](#create-the-sqs-queues)
    - [Attach SQS Permissions to the IAM Role for Lambda](#attach-sqs-permissions-to-the-iam-role-for-lambda)
    - [Link the SQS Queues and Lambda Function](#link-the-sqs-queues-and-lambda-function)
    - [Configure Logging to CloudWatch](#configure-logging-to-cloudwatch)
    - [Testing our Setup](#testing-our-setup)
    - [References:](#references)
- [Lab 03: VPC with EC2 instance](#lab-03-vpc-with-ec2-instance)
    - [Create the Provider file](#create-the-provider-file)
    - [Create the Main file](#create-the-main-file)
    - [Create the Variables files](#create-the-variables-files)
    - [Create the Outputs file](#create-the-outputs-file)
    - [Test it out](#test-it-out)
    - [Cleanup](#cleanup)
- [Lab 04: Advanced VPC with ALB and EC2 instances](#lab-04-advanced-vpc-with-alb-and-ec2-instances)
    - [Create the Provider file](#create-the-provider-file)
    - [Create the datasources file](#create-the-datasources-file)
    - [Create the Main file](#create-the-main-file)
    - [cidrsubnet function](#cidrsubnet-function)
    - [Launch template](#launch-template)
    - [Validate](#validate)
    - [Test it out](#test-it-out)
- [Lab 05: Advanced VPC with ALB and EC2 instances - Simplified](#lab-05-advanced-vpc-with-alb-and-ec2-instances---simplified)
    - [Verify](#verify)
    - [Cleanup](#cleanup)
- [Lab 06: Advanced VPC with Cloud-Native Application](#lab-06-advanced-vpc-with-cloud-native-application)
    - [Introduction](#introduction)
    - [Create the Provider file and other Config Files](#create-the-provider-file-and-other-config-files)
    - [Modularize Terraform Configuration files](#modularize-terraform-configuration-files)
        - [Network Module](#network-module)
        - [Security Module](#security-module)
        - [Bastion Module](#bastion-module)
        - [Storage Module](#storage-module)
        - [Application Module](#application-module)
    - [Configure the variables file](#configure-the-variables-file)
    - [Configure the outputs file](#configure-the-outputs-file)
    - [About the Cloud-native Application](#about-the-cloud-native-application)
    - [Time to Apply!](#time-to-apply)
    - [Cleanup](#cleanup)
- [Lab 07: Installing Terraform on a Windows Server](#lab-07-installing-terraform-on-a-windows-server)
    - [Launch a Windows instance](#launch-a-windows-instance)
    - [Connect to your instance](#connect-to-your-instance)
    - [Install Terraform](#install-terraform)
    - [Cleanup](#cleanup)
- [Lab 08: Deploy DynamoDB and Solve Implicit Dependencies](#lab-08-deploy-dynamodb-and-solve-implicit-dependencies)
    - [Introduction](#introduction)
    - [Create the Provider file](#create-the-provider-file)
    - [Create the Variable files](#create-the-variable-files)
    - [Create the Main file](#create-the-main-file)
    - [Time to Apply!](#time-to-apply)
    - [Understanding the Error](#understanding-the-error)
    - [Visualize the Config file](#visualize-the-config-file)
    - [Now that we know what the error means](#now-that-we-know-what-the-error-means)
    - [Cleanup](#cleanup)
- [Lab 09: Lookup Function and Different Types of Variables](#lab-09-lookup-function-and-different-types-of-variables)
    - [Introduction](#introduction)
    - [Create the Provider file](#create-the-provider-file)
    - [Create the Main file](#create-the-main-file)
    - [Create the variable files](#create-the-variable-files)
    - [Time to Apply!](#time-to-apply)
    - [Cleanup](#cleanup)
- [Lab 10: Create an ECR Resource and Use Provisioners](#lab-10-create-an-ecr-resource-and-use-provisioners)
- [Lab 11: Deploy an S3 Bucket](#lab-11-deploy-an-s3-bucket)
- [Pre-requisites](#pre-requisites)
    - [Setup Keys and Permissions](#setup-keys-and-permissions)
    - [Setup your Environment and Install Extensions](#setup-your-environment-and-install-extensions)
        - [AWS Toolkit Extension](#aws-toolkit-extension)
        - [Terraform Extension](#terraform-extension)
    - [Configure the Credentials File](#configure-the-credentials-file)
    - [Install Terraform on Linux](#install-terraform-on-linux)
    - [Install Terraform on a Windows Server](#install-terraform-on-a-windows-server)
    - [Install AWS CLI and Configure with the Credentials](#install-aws-cli-and-configure-with-the-credentials)
    - [Create the keypair](#create-the-keypair)
- [Resources](#resources)

<!-- /TOC -->

----------------------------------------------

## Terraform Basics

From the official [Hashicorp documentation:](https://www.terraform.io/docs)

> Terraform is an infrastructure as code (IaC) tool that allows you to build, change, and version infrastructure safely and efficiently. This includes both low-level components like compute instances, storage, and networking, as well as high-level components like DNS entries and SaaS features.

Terraform can be used to:
- provision on-prem resources
- provision multi-cloud deployments
- has open-source but also has *Terraform Cloud*
- codify infra into machine-readable executable documentation
- repeatable infra builds
- manage and maintain infra configuration drift
- version-controll through git
- integrate with CICD systems

### Provisioning Workflow

- terraform validate
- terraform plan 
- terraform apply
- terraform destroy

### Public Module registry

This is a collection of community builds and reusable Terraform modules that can be imported and used.

### Providers

Used to perform infrastructure provisioning.

### Terraform Root Module

This is a directory on the local filesystem containing all the configuration files and code files. This is typically consists of three files:

- main.tf
- variables.tf
- outputs.tf

This root directory may also contain:

- terraform.state
- terraform.state.backup

### Terraform Workspaces

![](Images/tfworkspaces.png)  

<small><center> *Photo courtesy of Cloud Academy course on "Terraform 1.0 - Provisioning AWS Infrastructure"* </center></small>

We can utilize **workspaces** to manage separate environments using the same set of configuration files.

```bash
$ terraform workspace 
```

To create a new workspace,

```bash
$ terraform workpace  new  <name> 
```

To select a workspace,

```bash
$ terraform workspace select <name>
```

### The main file - main.tf

Contains the core configurations:
- Resources
- Provider 
- Data Sources 

This file can be modularized by splitting the sections into their own separate .tf files.

### The variables files - variables.tf

Contains all possible variables referenced in the main.tf file.

----------------------------------------------

### terraform.tfvars vs variables.tf 

From a [stackoverflow discussion:](https://stackoverflow.com/questions/56086286/terraform-tfvars-vs-variables-tf-difference)

> The distinction between these is of declaration vs. assignment.
>
> **variable** blocks (which can actually appear in any .tf file, but are in variables.tf by convention) declare that a variable exists.

Check out the example below. This tells Terraform that this module accepts an input variable called example. Stating this makes it valid to use var.example elsewhere in the module to access the value of the variable.

There are several different ways to assign a value to this input variable:

* Include **-var** options on the **terraform plan** or terraform **apply** command line.

* Include **-var-file** options to select one or more **.tfvars** files to set values for many variables at once.

* Create a **terraform.tfvars** file, or files named **.auto.tfvars**, which are treated the same as -var-file arguments but are loaded automatically.

* For a child module, include an expression to assign to the variable inside the calling module block.


```bash
variable "example" {} 
```

A variable can optionally be declared with a default value, which makes it optional. Variable defaults are used for situations where there's a good default behavior that would work well for most uses of the module/configuration, while still allowing that behavior to be overridden in exceptional cases.

Note that you cannot define new variables in **terraform.tfvars** file, which means you must declare the variables in the **variables.tf** file.

You may opt to define all the variables and assign values to them in the **variables.tf**.

**References:**

- [terraform.tfvars vs variables.tf difference [duplicate]](https://stackoverflow.com/questions/56086286/terraform-tfvars-vs-variables-tf-difference)

- [[What is the difference between variables.tf and terraform.tfvars?]](https://stackoverflow.com/questions/55959202/what-is-the-difference-between-variables-tf-and-terraform-tfvars)

### The outputs file - outputs.tf 

Used to explicitly export values after you ran **terraform apply** .
- outputs can be references within any parent templates
- often used to create modules

### Terraform State

Terraform is a STATEFUL application - this means it keeps track of all infra prvisione dbeond Day 0.
- manage lifecycle of infra
- manage infra configuration drift
- state can be refreshed using *terraform refresh*

### Terraform State - Remote State  

By default, the terraform state is sotre on the local filesystem. It can be also configured to store the state remotely.
- could be stored in S3 bucket
- supports team collaboration
- considered more secure
- data encrypted at rest + TLS connections

### Terraform State - Locking

State files are locked during writes to prevent potential conflict or corruption.

----------------------------------------------

### Authentication

Before we start with building the code, we have to ensure that we'll be able to authenticate using API keys. 

Note that you have options on how to setup the authentication. Note that if you have all of these configured, Terraform will read it in these order:

- hardcode the API keys and secrets on the main.tf, under the provider section, but this is insecure

- environment variables

- using a shared_credentials_file

Follow these steps to [create the API keys and the credentials file locally.](#setup-keys-and-permissions)   

----------------------------------------------

### Setup Local Environment

For this one, I'm using VS Code. We'll set it up with the following extensions:

- AWS Toolkit Extension
- Terraform Extension

Follow these steps to [setup your Visual Studio Code.](#setup-your-environment-and-install-extensions)
 
----------------------------------------------

### Install Terraform

To use Terraform, it needs to be installed on our local machine.

Follow these steps to [install Terraform.](#install-terraform)

----------------------------------------------

### Terraform CLI

You can read more about the available Terraform CLI commands in the [Hashicorp documentation.](https://www.terraform.io/cli/commands)

Here is a summarized cheatsheet.

![](Images/tfclicheatsheet.png)  

<small><center> *Photo courtesy of ["The Essential Terraform Cheatsheet"](https://justinoconnor.codes/2021/09/06/the-essential-terraform-cheat-sheet/)*</center></small>

----------------------------------------------

### Terraform HCL Language

From the Hashicorp documentation on [syntax:](https://www.terraform.io/language/syntax)

> 
> The majority of the Terraform language documentation focuses on the practical uses of the language and the specific constructs it uses. The pages in this section offer a more abstract view of the Terraform language.
>
> **Configuration Syntax** describes the native grammar of the Terraform language.
>
> **JSON Configuration Syntax** documents how to represent Terraform language constructs in the pure JSON variant of the Terraform language. Terraform's JSON syntax is unfriendly to humans, but can be very useful when generating infrastructure as code with other systems that don't have a readily available HCL library.
>
> **Style Conventions documents** some commonly accepted formatting guidelines for Terraform code. These conventions can be enforced automatically with terraform fmt.

To add comments, use the '#'.

```
# This is a comment 
```

To add multi-line comments, enclose them in '/* */'.

```
/* This is 
a comment
with three lines
*/ 

```

To add single-line strings, enclose them in double quotes

```
"This is a single-line string"
```

For multi-line string, use 'EOF'

```
<<<EOF
This message 
is composed of
three lines.
>>>
```

You can read more about configuration syntax [here](https://www.terraform.io/language/syntax/configuration).

----------------------------------------------

## Lab 01: Build a Dev Environment with Terraform and AWS

### Introduction

In this lab, we'll build the following resources in AWS

- VPC
- route table
- Internet gateway
- public subnet
- security group
- an EC2 instance

![](Images/dmbuildaws.png)  

Below is the environment I am using for this lab. 
- Windows machine/laptop
- Visual Studio Code v1.67.2 (VSCode)
- WSL on Visual Studio Code
- Amazon Web Services (AWS) resources

----------------------------------------------

### Authentication

Before we start with building the code, we have to ensure that we'll be able to authenticate using API keys. 

Follow these steps to [create the API keys and the credentials file locally.](#setup-keys-and-permissions)                                                             

----------------------------------------------

### Setup Local Environment

For this one, I'm using VS Code. We'll set it up with the following extensions:

- AWS Toolkit Extension
- Terraform Extension

Follow these steps to [setup your Visual Studio Code.](#setup-your-environment-and-install-extensions)
 
----------------------------------------------

### Install Terraform

To use Terraform, it needs to be installed on our local machine.

Follow these steps to [install Terraform.](#install-terraform)

----------------------------------------------

### Configure AWS Provider

From the [Hashicorp's documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs):

> Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS. You must configure the provider with the proper credentials before you can use it.

Since we already created the credentials file, we can proceed to creating the provider file. 

Note that it is recommended to use variableS for configuration files instead of hardcoding any credentials. Another option is to specify the credentials file path.

```bash
$ cat > provider.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "ap-southeast-1"
  shared_credentials_file  = "/mnt/c/Users/Eden.Jose/.aws/credentials"
  profile                  = "vscode-dev"
}
```

Initialize.
```bash
$ terraform  init
```

----------------------------------------------

### Provision a VPC

From the Hashicorp documentation, we could see various AWS resources can be deployed. For this step, we'll be using [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) to provide a VPC resource.

Let's start with creating a main file. Here we'll specify the following:
- VPC name "tf-vpc" after the **aws_vpc**
- cidr block of 10.123.0.0/16
- enable hostname
- enable dns support, optional

```bash
resource "aws_vpc" "tf-vpc" {
   cidr_block = "10.123.0.0/16"
   enable_dns_hostnames = true
   enable_dns_support = true

   tags = {
       Name = "tf-vpc-dev"
   }
} 
```

To get a "preview" without actually provisioning the resources,
```bash
$ terraform plan
```

This should return a list of resources that would be created if the template is ran. Below is an example output.

<details><summary> output for terraform plan</summary>

```bash
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.tf-vpc will be created
  + resource "aws_vpc" "tf-vpc" { 
      + arn                                  = (known after apply)
      + cidr_block                           = "10.123.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_classiclink                   = (known after apply)
      + enable_classiclink_dns_support       = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "tf-vpc-dev"
        }
      + tags_all                             = {
          + "Name" = "tf-vpc-dev"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

</details>
</br>

To actually provision the resources,
```bash
$ terraform apply 
```

Notice that this will do another **terraform plan**, after which you'll be asked if you want to perform the actions. 

To run the command above without the interactive prompt,
```bash
$ terraform apply -auto-approve
```

When the command is finished running, it should return the followin message:

```bash
Plan: 1 to add, 0 to change, 0 to destroy.
aws_vpc.tf-vpc: Creating...
aws_vpc.tf-vpc: Still creating... [10s elapsed]
aws_vpc.tf-vpc: Creation complete after 15s [id=vpc-00203af585d54c4f0]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

On the Explorer tab on the left in VSCode, you should still see the available resources for Asia Pacific region when you click the AWS icon on the left panel. Sctoll at the bottom and then click,

```bash
Resources --> Enable resources types... -->  AWS::EC2::VPC --> OK
```

![](Images/builddevtfvpccreated.png)  
![](Images/builddevec2vpcvcodeleftpanel.png)  

When you click the VPC ID, it should open the configuration file.

```bash
{
    "VpcId": "vpc-00203af585d54c4f0",
    "InstanceTenancy": "default",
    "CidrBlockAssociations": [
        "vpc-cidr-assoc-0546f97f1de6e8d65"
    ],
    "CidrBlock": "10.123.0.0/16",
    "DefaultNetworkAcl": "acl-0b52f6d2d6f4c8339",
    "EnableDnsSupport": true,
    "Ipv6CidrBlocks": [],
    "DefaultSecurityGroup": "sg-06fc3a39cbe08b627",
    "EnableDnsHostnames": true,
    "Tags": [
        {
            "Value": "tf-vpc-dev",
            "Key": "Name"
        }
    ]
} 
```

----------------------------------------------

### Terraform State

From the Hashicorp documentation page on [terraform state](https://www.terraform.io/language/state) :

> Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.
> 
> This state is stored by default in a local file named "terraform.tfstate", but it can also be stored remotely, which works better in a team environmen

To access the state through the CLI,

```bash
$ terraform state list 

aws_vpc.tf-vpc
```

To see details of the VPC through the CLI, run the command below. This will return the same information that you see on the state file.

```bash
$ terraform state show aws_vpc.tf-vpc
```

To see the entire state,

```bash
$ terraform show  
```

----------------------------------------------

### Terraform Destroy

From Hashicorp documentation page on [terraform destroy](https://www.terraform.io/cli/commands/destroy):

> The terraform destroy command is a convenient way to destroy all remote objects managed by a particular Terraform configuration.
> 
> While you will typically not want to destroy long-lived objects in a production environment, Terraform is sometimes used to manage ephemeral infrastructure for development purposes, in which case you can use terraform destroy to conveniently clean up all of those temporary objects once you are finished with your work.

To see a "preview" of the resources that will be destroyed before actually deleting them,
```bash
$ terraform plan -destroy 
```

To actually delete the resource without being prompted to confirm,
```bash
$ terraform destroy -auto-approve
```

----------------------------------------------

### Deploy a Public Subnet

From Hashicorp documentation page on [AWS VPC Subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet):

> Provides an VPC subnet resource.

The documentation page is straightforward and we could simply the basic usage example. Note that we're launching a public subnet, we will need **map_public_ip_on_launch** set to **true** to ensure EC2 instances that will be launched in the  public subnet will be assigned a public IP.

Back on the main file, we'll add the resource **aws_subnet** and name it **tf-public-subnet-1**

<details><summary> main.tf</summary>

```bash
resource "aws_vpc" "tf-vpc" {
   cidr_block = "10.123.0.0/16"
   enable_dns_hostnames = true
   enable_dns_support = true

   tags = {
       Name = "tf-vpc-dev"
   }
} 

resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "tf-public-subnet-1"
  }
}
```
</details>
</br>

Review.

```bash
$ terraform plan 
```

Once you've reviewed, apply.

```bash
$ terraform apply -auto-approve 
```

Note that you cannot view the newly created subnet in the VSCode Explorer tab but you can verify them through the CLI.

```bash
$ terraform state list

aws_subnet.tf-public-subnet-1
aws_vpc.tf-vpc
```

Similarly, you can also check them on the AWS console.

![](Images/buildddevawsconsolevpccreate.png)  

![](Images/consolesubnetcreated.png)  

----------------------------------------------

### Deploy an Internet Gateway

To allow internet access to our VPC, we would need to provision an internet gateway. You can read more on the [Hashicorp documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway).

Back in our main file, we'll add another resource **aws_internet_gateway** and name it **tf-igw-1**.

<details><summary> main.tf </summary>

```bash

resource "aws_vpc" "tf-vpc" {
   cidr_block = "10.123.0.0/16"
   enable_dns_hostnames = true
   enable_dns_support = true

   tags = {
       Name = "tf-vpc-dev"
   }
} 

resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "tf-public-subnet-1"
  }
}

resource "aws_internet_gateway" "tf-igw-1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-igw-1"
  }
} 
```

</details>
</br>

Review.

```bash
$ terraform plan 
```

Once you've reviewed, apply.

```bash
$ terraform apply -auto-approve 
```

Verify through the VSCode Explorer tab on the left panel.

```bash
Resources --> Show Resources --> AWS::EC2::InternetGateway --> OK
```

![](Images/builddevigwcreated.png)  

Verify through the CLI.

```bash
$ terraform state list

aws_internet_gateway.tf-igw-1
aws_subnet.tf-public-subnet-1
aws_vpc.tf-vpc
```

----------------------------------------------

### Terraform Format

This is a neat feature which will correct any formatting errors that you may have on your template files.

```bash
$ terraform fmt 
```

----------------------------------------------

### Create the Route table

After you've provisioned an internet gateway, you need to create a route table to route traffic from the public subnet to the internet gateway.

When you search for the route table on the Hashicorp documentation, you'll see two resources, **aws_route_table** and **aws_route**

From the Hashicorp documentation on [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table):

> Provides a resource to create a VPC routing table.

From the Hashicorp documentation on [aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route):

> Provides a resource to create a routing table entry (a route) in a VPC routing table.

On both page, you'll see the following,

> **NOTE on Route Tables and Routes:**
> Terraform currently provides both a standalone Route resource and a Route Table resource with routes defined in-line. At this time you cannot use a Route Table with in-line routes in conjunction with any Route resources. Doing so will cause a conflict of rule settings and will overwrite rules.

Back in our main file, we'll be using both resources. To allow our public subnet to access internet, we should specify the destination as **0.0.0.0/0**


<details><summary> main.tf</summary>

```bash
resource "aws_vpc" "tf-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf-vpc-dev"
  }
}

resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tf-public-subnet-1"
  }
}

resource "aws_internet_gateway" "tf-igw-1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-igw-1"
  }
}


resource "aws_route_table" "tf-rt-table" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-rt-1-public"
  }
}

resource "aws_route" "tf-rt-route" {
  route_table_id         = aws_route_table.tf-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-igw-1.id
}
```
</details>
</br>

Review.

```bash
$ terraform plan 
```

Once you've reviewed, apply.

```bash
$ terraform apply -auto-approve 
```

Verify through the VSCode Explorer tab on the left panel.

```bash
Resources --> Show Resources --> AWS::EC2::Route --> OK
```

![](Images/builddevroutetablecreated.png)  

Verify through the CLI.

```bash
$ terraform state list
```

----------------------------------------------

### Create the Route Table Association

From the Hashicorp documentation on [route table association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association):

> Provides a resource to create an association between a route table and a subnet or a route table and an internet gateway or virtual private gateway.

Back in our main file, add another resource called **aws_route_table_association** and name it **tf-rt-assoc-1**

<details><summary> main.tf </summary>
 
```bash
 
resource "aws_vpc" "tf-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf-vpc-dev"
  }
}

resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tf-public-subnet-1"
  }
}

resource "aws_internet_gateway" "tf-igw-1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-igw-1"
  }
}


resource "aws_route_table" "tf-rt-table" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-rt-1-public"
  }
}

resource "aws_route" "tf-rt-route" {
  route_table_id         = aws_route_table.tf-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-igw-1.id
}

resource "aws_route_table_association" "tf-rt-assoc-1" {
  subnet_id      = aws_subnet.tf-public-subnet-1.id
  route_table_id = aws_route_table.tf-rt-table.id
}
```
 
</details>
</br>

Review.

```bash
$ terraform plan 
```

Once you've reviewed, apply.

```bash
$ terraform apply -auto-approve 
```

Similar with subnet, we also can't view the newly created resource through the VSCode Explorer tab on the left panel.

Instead, we could verify through the CLI.

```bash
$ terraform state list

aws_internet_gateway.tf-igw-1
aws_route.tf-rt-route
aws_route_table.tf-rt-table
aws_route_table_association.tf-rt-assoc-1
aws_subnet.tf-public-subnet-1
aws_vpc.tf-vpc
```

Check on the console.

![](Images/builddevroutetableassoccreated.png)  

----------------------------------------------

### Create the Security Group

From the Hashicorp documentation on [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group):

> Provides a security group resource.


From the Hashicorp documentation on [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule):

> Provides a security group rule resource. Represents a single ingress or egress group rule, which can be added to external Security Groups.

For our setup, we can simple use aws_security_group. Make sure to get your IP through [whatsmyip](https://whatismyipaddress.com/) and set it fro **cidr_blocks** under **ingress**.

<details><summary> main.tf </summary>
 
```bash

resource "aws_vpc" "tf-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf-vpc-dev"
  }
}

resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tf-public-subnet-1"
  }
}

resource "aws_internet_gateway" "tf-igw-1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-igw-1"
  }
}

resource "aws_route_table" "tf-rt-table" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-rt-1-public"
  }
}

resource "aws_route" "tf-rt-route" {
  route_table_id         = aws_route_table.tf-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-igw-1.id
}

resource "aws_route_table_association" "tf-rt-assoc-1" {
  subnet_id      = aws_subnet.tf-public-subnet-1.id
  route_table_id = aws_route_table.tf-rt-table.id
}

resource "aws_security_group" "tf-sg-1" {
  name        = "tf-sg-1"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["1.2.3.4/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg-1"
  }
}
```
 
</details>
</br>


Review.

```bash
$ terraform plan 
```

Once you've reviewed, apply.

```bash
$ terraform apply -auto-approve 
```

Verify through the CLI.

```bash
$ terraform state list

aws_internet_gateway.tf-igw-1
aws_route.tf-rt-route
aws_route_table.tf-rt-table
aws_route_table_association.tf-rt-assoc-1
aws_security_group.tf-sg-1
aws_subnet.tf-public-subnet-1
```

Check on the AWS console.

![](Images/builddevawsconsolesgcreated.png)  

----------------------------------------------

### Get the AMI Datasource

From the Hashicorp documentation on [Data Source-aws_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami):

> Use this data source to get the ID of a registered AMI for use in other resources.

Before we proceed, we need to get the AMI ID which can be found in the EC2 menu through the AWS Console

```bash
EC2 --> Select AMI Catalog on the left panel --> Search Ubuntu --> Copy AMI ID
```

![](Images/builddevgetamiid2.png)   

Then select **AMI** on the left panel again and on the drop-down bar, choose **Public Images**.

![](Images/builddevgetowner.png)  

Paste the AMI ID on the search bar and from the result, copy the owner ID and AMI name

![](Images/builddevgetowneridaminame.png)  

Back on our lab directory, create another file called **datasource.tf**. On the values field under filter, put in the AMI name. To ensure that it will pull the most recent one, replace the 8-digits at the end of the AMI name with '*'

```bash
$ vim datasources.tf

data "aws_ami" "tf-ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
```

Review.

```bash
$ terraform plan 
```

Once you've reviewed, apply.

```bash
$ terraform apply -auto-approve 
```

----------------------------------------------

### Create a Keypair

For this step, we'll create a keypair that we'll be use by the EC2 instance to be created.

From the Hashicorp documentation on [aws_keypair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair):

> Provides an EC2 key pair resource. A key pair is used to control login access to EC2 instances.
>
> Currently this resource requires an existing user-supplied key pair. This key pair's public key will be registered with AWS to allow logging-in to EC2 instances.

To start with, we'll need a keypair locally.

```bash
$ ssh-keygen -t ed25519

Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/joseeden/.ssh/id_ed25519): /home/joseeden/.ssh/tf-keypair  
```

Back in our main.tf file, we'll add the resource **aws_keypair** and name it **tf-keypair** at the bottom. 


<details><summary> main.tf </summary>
 
```bash

resource "aws_vpc" "tf-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf-vpc-dev"
  }
}

resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tf-public-subnet-1"
  }
}

resource "aws_internet_gateway" "tf-igw-1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-igw-1"
  }
}

resource "aws_route_table" "tf-rt-table" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-rt-1-public"
  }
}

resource "aws_route" "tf-rt-route" {
  route_table_id         = aws_route_table.tf-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-igw-1.id
}

resource "aws_route_table_association" "tf-rt-assoc-1" {
  subnet_id      = aws_subnet.tf-public-subnet-1.id
  route_table_id = aws_route_table.tf-rt-table.id
}

resource "aws_security_group" "tf-sg-1" {
  name        = "tf-sg-1"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["1.2.3.4/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg-1"
  }
}

resource "aws_key_pair" "tf-keypair" {
  key_name   = "tf-keypair"
  public_key = file("/home/joseeden/.ssh/tf-keypair.pub")
}
```
 
</details>
</br>

Notice that instead of specifying the entire key in the **public_key** field as shown in the documentation, we use the [file](https://www.terraform.io/language/functions/file) function to pass the path of the key instead.

Review.

```bash
$ terraform plan 
```

Once you've reviewed, apply.

```bash
$ terraform apply -auto-approve
```

Keypairs aren't a visible resource in the VSCode AWS extension so we'll just verify through CLI and the AWS Console.


```bash
$ terraform state list

data.aws_ami.tf-ami
aws_internet_gateway.tf-igw-1
aws_key_pair.tf-keypair
aws_route.tf-rt-route
aws_route_table.tf-rt-table
aws_route_table_association.tf-rt-assoc-1
aws_security_group.tf-sg-1
aws_subnet.tf-public-subnet-1
aws_vpc.tf-vpc
```

![](Images/builddevkeypaircreated.png)  

----------------------------------------------

### Deploy the EC2 Instance

From the Hashicorp documentation on [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance):

> Provides an EC2 instance resource. This allows instances to be created, updated, and deleted. Instances also support provisioning.

Back in our main.tf file, we'll add a resource called **aws_instance** and name it **tf-node-1**

<details><summary> main.tf </summary>
 
```bash
resource "aws_vpc" "tf-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf-vpc-dev"
  }
}

resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tf-public-subnet-1"
  }
}

resource "aws_internet_gateway" "tf-igw-1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-igw-1"
  }
}

resource "aws_route_table" "tf-rt-table" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-rt-1-public"
  }
}

resource "aws_route" "tf-rt-route" {
  route_table_id         = aws_route_table.tf-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-igw-1.id
}

resource "aws_route_table_association" "tf-rt-assoc-1" {
  subnet_id      = aws_subnet.tf-public-subnet-1.id
  route_table_id = aws_route_table.tf-rt-table.id
}

resource "aws_security_group" "tf-sg-1" {
  name        = "tf-sg-1"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["1.2.3.4/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg-1"
  }
}

resource "aws_key_pair" "tf-keypair" {
  key_name   = "tf-keypair"
  public_key = file("/home/joseeden/.ssh/tf-keypair.pub")
}

resource "aws_instance" "tf-node-1" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.tf-ami.id
  key_name               = aws_key_pair.tf-keypair.id
  vpc_security_group_ids = [aws_security_group.tf-sg-1.id]
  subnet_id              = aws_subnet.tf-public-subnet-1.id

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "tf-node-1"
  }
}
```
 
</details>
</br>


Review.

```bash
$ terraform plan 
```

For this step, we'll just review. We'll pass the userdata next and then we apply.

----------------------------------------------

### Bootstrap EC2 with Userdata

We'll install the Docker engine on the EC2 instance using the userdata. To start with, let's first create the userdata script.

```bash
$ cat > userdata.tpl

#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update -y &&
sudo sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker ubuntu
```

Back on our main.tf, add the **user_data** under the **aws_instance** resource.

<details><summary> main.tf </summary>
 
```bash
resource "aws_vpc" "tf-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf-vpc-dev"
  }
}

resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tf-public-subnet-1"
  }
}

resource "aws_internet_gateway" "tf-igw-1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-igw-1"
  }
}

resource "aws_route_table" "tf-rt-table" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-rt-1-public"
  }
}

resource "aws_route" "tf-rt-route" {
  route_table_id         = aws_route_table.tf-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-igw-1.id
}

resource "aws_route_table_association" "tf-rt-assoc-1" {
  subnet_id      = aws_subnet.tf-public-subnet-1.id
  route_table_id = aws_route_table.tf-rt-table.id
}

resource "aws_security_group" "tf-sg-1" {
  name        = "tf-sg-1"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["1.2.3.4/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg-1"
  }
}

resource "aws_key_pair" "tf-keypair" {
  key_name   = "tf-keypair"
  public_key = file("/home/joseeden/.ssh/tf-keypair.pub")
}

resource "aws_instance" "tf-node-1" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.tf-ami.id
  key_name               = aws_key_pair.tf-keypair.id
  vpc_security_group_ids = [aws_security_group.tf-sg-1.id]
  subnet_id              = aws_subnet.tf-public-subnet-1.id
  user_data              = file("userdata.tpl")
  
  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "tf-node-1"
  }
}
```
 
</details>
</br>


Review.

```bash
$ terraform plan 
```

Once you've reviewed, apply.

```bash
$ terraform apply -auto-approve 
```

Provisioning the EC2 instance and running the userdata script will take a few minutes. Go to the AWS Console and verify that the EC2 instance is in "running" status.

![](Images/builddevec2instancecreated.png)  

Verify through the CLI.

```bash
$ terraform state list

data.aws_ami.tf-ami
aws_instance.tf-node-1
aws_internet_gateway.tf-igw-1
aws_key_pair.tf-keypair
aws_route.tf-rt-route
aws_route_table.tf-rt-table
aws_route_table_association.tf-rt-assoc-1
aws_security_group.tf-sg-1
aws_subnet.tf-public-subnet-1
aws_vpc.tf-vpc
```

Next step is to SSH to the newly created instance. You can get the IP from the AWS Console or you can also get it from the CLI.

```bash
$ terraform state list

data.aws_ami.tf-ami
aws_instance.tf-node-1
aws_internet_gateway.tf-igw-1
aws_key_pair.tf-keypair
aws_route.tf-rt-route
aws_route_table.tf-rt-table
aws_route_table_association.tf-rt-assoc-1
aws_security_group.tf-sg-1
aws_subnet.tf-public-subnet-1
aws_vpc.tf-vpc

$ terraform state aws_instance.tf-node-1

public_ip                            = "18.1.2.3"
```

Connect to the instance.

```bash
$ ssh -i ~/.ssh/tf-keypair ubuntu@18.1.2.3

ubuntu@ip-10-123-1-62:~$ docker -v
Docker version 20.10.16, build aa7e414
```

----------------------------------------------

### Create SSH Config Scripts - Templatefile

Search the **Remote-SSH** extensions in your VSCode.

![](Images/builddevremotesshextension.png)  

For Windows machines, we can create a file named **ssh-windows.tpl**.

```bash
add-content -path c:/users/derek/.ssh/config -value @'

Host ${hostname}
  HostName ${hostname}
  User ${user}
  IdentityFile ${identityfile}
'@ 
```

Since I'm using WSL, I'll be creating a file named **ssh-linux.tpl**.

```bash
cat << EOF >> /mnt/c/Users/Eden.Jose/.ssh/config

Host ${hostname}
  HostName ${hostname}
  User ${user}
  IdentityFile ${identityfile}
EOF
```

----------------------------------------------

### Configure VSCode with Provisioner

From the Hashicorp documentation on [Provisioners](https://www.terraform.io/language/resources/provisioners/syntax):

> Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.

**Provisioners as last resort**

Provisioners are created as a workaround for some functions that can't be directly represented in Terraform's declarative model. This could include:
- Passing data into virtual machines and other compute resources
- Running configuration management software
- First-class Terraform provider functionality may be available

Having said, it is not recommended to use provisioners on every deployment. Provisioner success and failure will not be reported by the terraform state. If something goes wrong, you can't roll back.

For this part of lab, it's okay to use provisioner since we're only modifying our config file through the local terminal.

Back in our main.tf file, we'll add a **provisioner** under the **aws_instance** resource.


<details><summary> main.tf </summary>
 
```bash

resource "aws_vpc" "tf-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf-vpc-dev"
  }
}

resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tf-public-subnet-1"
  }
}

resource "aws_internet_gateway" "tf-igw-1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-igw-1"
  }
}

resource "aws_route_table" "tf-rt-table" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-rt-1-public"
  }
}

resource "aws_route" "tf-rt-route" {
  route_table_id         = aws_route_table.tf-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-igw-1.id
}

resource "aws_route_table_association" "tf-rt-assoc-1" {
  subnet_id      = aws_subnet.tf-public-subnet-1.id
  route_table_id = aws_route_table.tf-rt-table.id
}

resource "aws_security_group" "tf-sg-1" {
  name        = "tf-sg-1"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["1.2.3.4/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg-1"
  }
}

resource "aws_key_pair" "tf-keypair" {
  key_name   = "tf-keypair"
  public_key = file("~/.ssh/tf-keypair.pub")
}

resource "aws_instance" "tf-node-1" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.tf-ami.id
  key_name               = aws_key_pair.tf-keypair.id
  vpc_security_group_ids = [aws_security_group.tf-sg-1.id]
  subnet_id              = aws_subnet.tf-public-subnet-1.id
  user_data              = file("userdata.tpl")

  provisioner "local-exec" {
    command = templatefile("ssh-linux.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/tf-keypair"
    })
    # interpreter = ["Powershell", "-Command"]
    interpreter = ["bash", "-c"]
  }

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "tf-node-1"
  }
}
```
 
</details>
</br>

Notice that we used a [templatefile](https://www.terraform.io/language/functions/templatefile) function to read the file from a given path. After the provisioner reads the config file, it passes the values onto the file. These values are the:
- IP of the instance
- username to be used for login
- identityfile, which is thee public key

Review.

```bash
$ terraform plan 
```

We can see from the output of the **plan** command that it didn't introduce any change to the state. This is because Terraform didn't detect anything different.

```bash
No changes. Your infrastructure matches the configuration. 
```

To update the EC2 instance, we'll use **-replace**.

```bash
$ terraform state list

data.aws_ami.tf-ami
aws_instance.tf-node-1
aws_internet_gateway.tf-igw-1
aws_key_pair.tf-keypair
aws_route.tf-rt-route
aws_route_table.tf-rt-table
aws_route_table_association.tf-rt-assoc-1
aws_security_group.tf-sg-1
aws_subnet.tf-public-subnet-1
aws_vpc.tf-vpc
```
```bash
$ terraform apply -replace aws_instance.tf-node-1 -auto-approve
```

Once it's finish running, check if the **config** file is created in your directory.

```bash
$ cat /mnt/c/Users/Eden.Jose/.ssh/config

Host 13.229.78.225
  HostName 13.229.78.225
  User ubuntu
  IdentityFile ~/.ssh/tf-keypair
```

Open **Remote-SSH** in VSCode. You should see the IP of your instance. When you click the IP, it will open a new VSCode window.

```bash
Click View --> Command Palette --> Remote-SSH: Connect to Host
```

![](Images/builddevvscoderemotedev.png)  

Select Linux, then choose Continue.

![](Images/builddevvscodechooselinux.png)  

![](Images/builddevremotedevcontinue.png)  

On the new VSCode window, open a terminal. You should now see a different prompt.

```bash
Click Terminal --> New Terminal
```

Click the **Open Folder** on the left panel. Select the home directory and then click **Yes. I trust the authors.**

![](Images/builddevconnectedtoremoteubuntu.png)  

![](Images/builddevconnectedreoteselecthomefolder.png) 

![](Images/builddevconnectedremotetrustauthors.png)  

![](Images/builddevconnectedremotelyopenedfolder.png)  

----------------------------------------------

### Variables and their precedence

From the Hashicorp documentation on [Variable Definition Precedence:](https://www.terraform.io/language/values/variables)

> Terraform loads variables in the following order, with later sources taking precedence over earlier ones:
> - Environment variables
> - The terraform.tfvars file, if present.
> - The terraform.tfvars.json file, if present.
> - Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
> - Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

To check the value of a variable that we currently have, we can use **console** and then type the variable name. As an example, let's create a **variables.tf** file.

```bash
$ cat > variables.tf

variables "host_os" {
    type = string
}
```

Let's now try to check the value of the variable through the CLI by using **console**. Notice that it will return nothing because we haven't specified a value to the variable yet.

```bash
$ terraform console

> var.host_os
(known after apply)
```

Let's specify a value to the variable in **variables.tf**

```bash
$ cat > variables.tf

variable "host_os" {
  type = string
  default = "linux" 
```

Using **console** again to check the value for the variable,

```bash
$ terraform console

> var.host_os
"linux" 
```

Let's create a new file called **terraform.tfvars**.

```bash
$ cat > terraform.tfvars

host_os = "windows"
```

Using **console** again to check the value for the same variable,

```bash
$ terraform console

> var.host_os
"windows" 
```

Here we can see that terraform gets the value from the **terraform.tfvars** instead of the **variables.tf**. This is because the default tfvars takes precedence over tf files.

**What if there's multiple tfvars file?**

Let's create **another.tfvars**

```bash
$ cat > another.tfvars

host_os = "debian"
```

To use this second tfvars file, we have to specify it as a parameter.

```bash
$ terraform console -var-file="another.tfvars"

> var.host_os
"debian"
```

Finally, we could override these files by specifying the variable through the commandline.

```bash
$ terraform console -var="host_os=unix"

> var.host_os
"unix"
```

----------------------------------------------

### Outputs

From the Hashicorp documentation on [outputs](https://www.terraform.io/language/values/outputs):

> Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages.

Let's create **outputs.tf** and put the value for the instance IP.

```bash
$ cat > outputs.tf

output "tf-node-1-ip" {
  value = aws_instance.tf-node-1.public_ip
} 
```

To apply the change without destroying and recreating the instance,

```bash
$ terraform apply -refresh-only
```

We can now see the output values "collected".

```bash
$ terraform output

tf-node-1-ip = "13.229.78.225"
```

----------------------------------------------

### References:

- [Github - morethancertified/rfp-terraform](https://github.com/morethancertified/rfp-terraform)


----------------------------------------------

## Lab 02: DEV Environment with SQS and Lambda 

### Introduction

In this lab, our setup would look like this:

1. We have an SQS main queue that will feed messages to a Lambda function that's written in Python.

2. The Lambda function will have 2 attemts to process the messages.

3. After two failed attempts, the function will send the message to a secondary queue, which is called a **Dead Letter Queue**.

----------------------------------------------

### Authentication

Before we start with building the code, we have to ensure that we'll be able to authenticate using API keys. 

Follow these steps to [create the API keys and the credentials file locally.](#setup-keys-and-permissions)                                                             

----------------------------------------------

### Setup Local Environment 

For this one, I'm using VS Code. We'll set it up with the following extensions:

- AWS Toolkit Extension
- Terraform Extension

Follow these steps to [setup your Visual Studio Code.](#setup-your-environment-and-install-extensions)
 
----------------------------------------------

### Install Terraform

To use Terraform, it needs to be installed on our local machine.

Follow these steps to [install Terraform.](#install-terraform)

----------------------------------------------

### Lambda function

Here is the Lambda function that we'll be using.

```python

# main.py
#---------------------------------------------------------------------------
# Lambda function that processes data from an SQS queue.
# After two failed attempts, functino sends message to a dead letter queue.
#---------------------------------------------------------------------------

import json

def lambda_handler(event, context):
  for k, v in event.items():
    print(k, v)

  return {
    'StatusCode': 200,
    'body': json.dumps('I feel the need, the need for speed!')
  }
```

----------------------------------------------

### Create the Provider file

From the [Hashicorp's documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs):

> Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS. You must configure the provider with the proper credentials before you can use it.

Let's start with creating the **provider.tf**

```bash
 terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16.0"
    }
  }

}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = var.my_credentials
  profile                  = var.my_profile
}
```

----------------------------------------------

### Create the Variables file

The variables file will contain all the variables that you'll use on your main template file.

```bash
variable "aws_region" {
  description = "AWS region"
  type        = string
    default     = "ap-southeast-1"
}

variable "my_credentials" {
  description = "Credentials to be used to connect to AWS"
  type        = list(string)
    default     = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
}

variable "my_profile" {
  description = "Profile to be used to connect to AWS"
  type        = string
    default     = "vscode-dev"
}  
```

Note that there's also a precedence of the variables. We can use the **variables.tf** if there are no **tfvars** file that exists. We'll create a default **terraform.tfvars** file.

```bash
aws_region     = "ap-southeast-1"
my_credentials = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
my_profile     = "vscode-dev" 
```

----------------------------------------------

### Create the main.tf file and run

After we've configured the variables and provider file, the next step is to create the **main.tf** which will contain all the resources we'll provision.

<details><summary> main.tf </summary>
 
```bash
# lab02_dev_sqs_lambda
#------------------------------------------------------

# Creates a zip file of the main.py function
data "archive_file" "tfzip" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}

# Creates lambda function
resource "aws_lambda_function" "lambda_python_test" {
  filename      = "main.zip"
  function_name = "lambda_python_test"
  role          = aws_iam_role.lambda_python_test_iam_role.arn
  handler       = "lambda_handler"
  runtime       = "python3.8"
  source_code_hash = data.archive_file.lambda_python_test.output_base64sha256
}

# Creates lambda iam role
resource "aws_iam_role" "lambda_python_test_iam_role" {
  name = "lambda_python_test_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
```
 
</details>
</br>

Then, initialize the working directory. For this lab, I've created a directory named **lab02_dev_sqs-lambda** which will contain all the files.

```bash
$ terraform init 
```

Review.

```bash
$ terraform plan 
```

If the command above didn't return any error, you can now run it. This will prompt you to confirm the changes you want to make.

```bash
$ terraform apply 
```

You can also set it to automatically approve the changes by running the command below.

```bash
$ terraform apply -auto-approve 
```

It should return this message if there's no error.

```bash
Apply complete! Resources: 2 added, 0 changed, 0 destroyed. 
```

To verify, click the AWS extension on the left panel in your VSCode. It should open an Explorer tab.

```bash
Right-click on Resources --> Show Resources --> AWS::Lambda::Function --> OK
```

![](Images/lab2lambda.png)  
![](Images/lab2lambdaonresources.png)  
![](Images/lab2lambdapythontest.png)  

Click the function name. It should open a JSON file.

```bash
{
    "MemorySize": 128,
    "Description": "",
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "Timeout": 3,
    "Handler": "lambda_handler",
    "Role": "arn:aws:iam::848587260896:role/lambda_python_test_iam_role",
    "FileSystemConfigs": [],
    "FunctionName": "lambda_python_test",
    "Runtime": "python3.8",
    "PackageType": "Zip",
    "Arn": "arn:aws:lambda:ap-southeast-1:848587260896:function:lambda_python_test",
    "EphemeralStorage": {
        "Size": 512
    },
    "Architectures": [
        "x86_64"
    ]
} 
```

Similarly, you can also check on the AWS Console and go to Lambda. Click the function to see its configuration.

![](Images/lab2awslambda.png)  
![](Images/lab2awslambda2.png)  


----------------------------------------------

### Test the Lambda function

Scroll down to the **Code** section at the bottom and double-click **main.py** to see the code. It's time to test it.

![](Images/lab2awslambda3.png)  

```bash
Dropdown "Test" --> Configure test event 
```

In the **Configure test event** prompt, name the test "test1". Keep the default settings for the rest and hit **Save** at the bottom.

![](Images/lab2awslambdaconfigtestevent1.png)  

Back in the **Code source** section, click **Test**. You'll see that it returns an error message. Lambda is actually complaining because it's not able to find the "lambda handler" file, which we actually named **main.py**.

![](Images/lab2awslambdatest1errror.png)  



----------------------------------------------

### Modify the Lambda Handler Name

To solve the error, we can edit the main.tf and change the **handler** value under the **aws_lambda_function** resource to "main.lambda_handler".

<details><summary> main.tf </summary>
 
```bash
# lab02_dev_sqs_lambda
#------------------------------------------------------

# Creates a zip file of the main.py function
data "archive_file" "tfzip" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}

# Creates lambda function
resource "aws_lambda_function" "lambda_python_test" {
  filename         = "main.zip"
  function_name    = "lambda_python_test"
  role             = aws_iam_role.lambda_python_test_iam_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("main.zip")
}

# Creates lambda iam role
resource "aws_iam_role" "lambda_python_test_iam_role" {
  name = "lambda_python_test_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
```
 
</details>
</br>

Review. If it doesn't return any error message, apply.

```bash
$ terraform plan  
```
```bash
$ terraform apply -auto-approve
```

Going back to the AWS Console, refresh the page and scroll down to the **Runtime settings** section. You should now see the new Handler name.

![](Images/lab2awslambdaeditedfunction.png)  

On the **Code source** section, hit test again. A StatusCode of 200, along with the message should appear.

![](Images/lab2awslambdasuccess.png)  


----------------------------------------------

### Create the SQS Queues

Recall that we'll be creating two SQS queues:
- main queue
- dead letter queue

Edit the main.tf to include the resource **aws_sqs_queue**.

<details><summary> main.tf </summary>
 
```bash
# lab02_dev_sqs_lambda
#------------------------------------------------------

# Creates a zip file of the main.py function

data "archive_file" "tfzip" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}

# Creates lambda function
resource "aws_lambda_function" "lambda_python_test" {
  filename         = "main.zip"
  function_name    = "lambda_python_test"
  role             = aws_iam_role.lambda_python_test_iam_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("main.zip")
}

# Creates lambda IAM role
resource "aws_iam_role" "lambda_python_test_iam_role" {
  name = "lambda_python_test_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole", 
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Create SQS-Main queue
resource "aws_sqs_queue" "lab2-main-queue" {
  name                      = "lab2-main-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# Create SQS-dead letter queue
resource "aws_sqs_queue" "lab2-dlq-queue" {
  name                      = "lab2-dlq-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}
```
 
</details>
</br>

Review. If it doesn't return any error message, apply.

```bash
$ terraform plan  
```
```bash
$ terraform apply -auto-approve
```

Verify if the two SQS queues are created through the AWS Console by going to the SQS menu.

![](Images/lab2sqs1.png)  

----------------------------------------------

### Attach SQS Permissions to the IAM Role for Lambda

So far, we've created the execution role for Lambda. However, this role doesn't have the necessary permissions for SQS, namely:
- sqs:ReceiveMessage
- sqs:DeleteMessage
- sqs:GetQueueAttributes

As such, we need to do the following steps:
- create the policy document
- create the actual IAM role policy from the policy document
- attach the IAM role policy to the IAM role

You may read more about the policy and policy attachments in the link below:

- [Data Source: aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)

- [Resource: aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)

- [Lambda service throws error execution role does not have permissions to call receiveMessage on SQS](https://stackoverflow.com/questions/55472987/lambda-service-throws-error-execution-role-does-not-have-permissions-to-call-rec)

Modify the main.tf file.

<details><summary> main.tf </summary>
 
```bash
# lab02_dev_sqs_lambda
#------------------------------------------------------

# Creates a zip file of the main.py function

data "archive_file" "tfzip" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}

# Creates lambda function
resource "aws_lambda_function" "lambda_python_test" {
  filename         = "main.zip"
  function_name    = "lambda_python_test"
  role             = aws_iam_role.lambda_python_test_iam_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("main.zip")
}

# Creates lambda IAM role
resource "aws_iam_role" "lambda_python_test_iam_role" {
  name = "lambda_python_test_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole", 
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Create SQS-Main queue
resource "aws_sqs_queue" "lab2-main-queue" {
  name                      = "lab2-main-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# Create SQS-dead letter queue
resource "aws_sqs_queue" "lab2-dlq-queue" {
  name                      = "lab2-dlq-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}


# Create the policy document which will contain the actions for accessing the SQS main queue.
data "aws_iam_policy_document" "sqs-policy-doc" {
  statement {
    sid = "1"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [
      aws_sqs_queue.lab2-main-queue.arn
    ]
  }
}

# Creates the policy from the policy document.
resource "aws_iam_policy" "sqs-policy" {
  name   = "sqs-policy"
  policy = data.aws_iam_policy_document.sqs-policy-doc.json
}

# Attaches the policy to the IAM role
resource "aws_iam_role_policy_attachment" "sqs-policy-attach" {
  role       = aws_iam_role.lambda_python_test_iam_role.name
  policy_arn = aws_iam_policy.sqs-policy.arn
}
```
 
</details>
</br>

We'll just do a review for this step. We'll apply the changes once we've linked the SQS main queue and Lambda function.

```bash
$ terraform plan 
```

----------------------------------------------

### Link the SQS Queues and Lambda Function

Now that we've create the SQS Queues and the Lambda function, and we've created and attached the necessary policies, the next step is establish the link between the two services. To do this, we will use the resource **aws_lambda_event_source_mapping**.

From the Hashicorp documentation on [aws_lambda_event_source_mapping:](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping)

> This allows Lambda functions to get events from Kinesis, DynamoDB, SQS, Amazon MQ and Managed Streaming for Apache Kafka (MSK).

Edit the main.tf to add the new resource.

<details><summary> main.tf </summary>
 
```bash
# lab02_dev_sqs_lambda
#--------------------------------------------------------------
# This terraform template deploys a main SQS queue which will 
# trigger a Lambda function.
#--------------------------------------------------------------

# Creates a zip file of the main.py function.
data "archive_file" "tfzip" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}

# Creates lambda function
resource "aws_lambda_function" "lambda_python_test" {
  filename         = "main.zip"
  function_name    = "lambda_python_test"
  role             = aws_iam_role.lambda_python_test_iam_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("main.zip")
}

# Creates lambda IAM role.
resource "aws_iam_role" "lambda_python_test_iam_role" {
  name = "lambda_python_test_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole", 
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Create SQS-Main queue
resource "aws_sqs_queue" "lab2-main-queue" {
  name                      = "lab2-main-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# Create SQS-dead letter queue
resource "aws_sqs_queue" "lab2-dlq-queue" {
  name                      = "lab2-dlq-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# Create the policy document which will contain the actions for 
# accessing the SQS main queue.
data "aws_iam_policy_document" "sqs-policy-doc" {

  statement {
    sid = "1"
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [
      aws_sqs_queue.lab2-main-queue.arn,
      aws_sqs_queue.lab2-dlq-queue.arn
    ]
  }
}

# Creates the policy from the policy document.
resource "aws_iam_policy" "sqs-policy" {
  name   = "sqs-policy"
  policy = data.aws_iam_policy_document.sqs-policy-doc.json
}

# Attaches the policy to the IAM role
resource "aws_iam_role_policy_attachment" "sqs-policy-attach" {
  role       = aws_iam_role.lambda_python_test_iam_role.name
  policy_arn = aws_iam_policy.sqs-policy.arn
}

# Creates the mapping between the SQS main queue and Lambda function.
resource "aws_lambda_event_source_mapping" "sqs-trigger" {
  event_source_arn = aws_sqs_queue.lab2-main-queue.arn
  function_name    = aws_lambda_function.lambda_python_test.arn
}
```
 
</details>
</br>

Review. This time we'll add an **-out** parameter which will output the results of the **plan** to a file if it doesn't return an error.

```bash
$ terraform plan -out lab2.tfplan
```

Note that the terraform plan file is in binary format and is intended to be read by Terraform and to be passed to **apply** or **destroy** commands as a way to verify that nothing has changed since you accepted the plan. You can read more about tfplan [here](https://www.terraform.io/cloud-docs/sentinel/import/tfplan).

To run the apply,

```bash
$ terraform apply "lab2.tfplan" 
```

Verify through the AWS Console if the triggers are created. Go to the Lambda menu, click the **lab2-main-queue** and click the **Lambda triggers** tab.

![](Images/lab2lambdatriggermainqueue.png)  

When this main queue receives a message, it will trigger the Lambda function.
You could also the SQS  trigger in the Lambda page.

![](Images/lab2lambdasqstriggeronlambdapage.png)  

----------------------------------------------

### Configure Logging to CloudWatch

As part of our testing, we will need to enable logging to CloudWatch. 
Lambda works by polling the queue for updates. When there is a new message, Lambda invokes the function **lambda_python_test** with this new event data from the queue. The function then runs and creates logs in Amazon CloudWatch.

To enable logging, add this **statement** under the **aws_iam_policy_document**.

```bash
  statement {
    sid = "2"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogDelivery",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
```

We also need to create the CloudWatch log group.

```bash
# Creates the CloudWatch Log group which will contain the Lambda logs
resource "aws_cloudwatch_log_group" "example" {
  name = "/aws/lambda/${aws_lambda_function.lambda_python_test.function_name}"
}
```

The main.tf should now look like this.

<details><summary> main.tf </summary>
 
```bash
# lab02_dev_sqs_lambda
#--------------------------------------------------------------
# This terraform template deploys a main SQS queue which will 
# trigger a Lambda function.
#--------------------------------------------------------------

# Creates a zip file of the main.py function.
data "archive_file" "tfzip" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}

# Creates lambda function
resource "aws_lambda_function" "lambda_python_test" {
  filename         = "main.zip"
  function_name    = "lambda_python_test"
  role             = aws_iam_role.lambda_python_test_iam_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("main.zip")
}

# Creates lambda IAM role.
resource "aws_iam_role" "lambda_python_test_iam_role" {
  name = "lambda_python_test_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole", 
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Create SQS-Main queue
resource "aws_sqs_queue" "lab2-main-queue" {
  name                      = "lab2-main-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# Create SQS-dead letter queue
resource "aws_sqs_queue" "lab2-dlq-queue" {
  name                      = "lab2-dlq-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# Create the policy document which will contain the actions for 
# accessing the SQS main queue.
data "aws_iam_policy_document" "sqs-policy-doc" {

  statement {
    sid = "1"
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [
      aws_sqs_queue.lab2-main-queue.arn,
      aws_sqs_queue.lab2-dlq-queue.arn
    ]
  }

  statement {
    sid = "2"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogDelivery",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

# Creates the policy from the policy document.
resource "aws_iam_policy" "sqs-policy" {
  name   = "sqs-policy"
  policy = data.aws_iam_policy_document.sqs-policy-doc.json
}

# Attaches the policy to the IAM role
resource "aws_iam_role_policy_attachment" "sqs-policy-attach" {
  role       = aws_iam_role.lambda_python_test_iam_role.name
  policy_arn = aws_iam_policy.sqs-policy.arn
}

# Creates the mapping between the SQS main queue and Lambda function.
resource "aws_lambda_event_source_mapping" "sqs-trigger" {
  event_source_arn = aws_sqs_queue.lab2-main-queue.arn
  function_name    = aws_lambda_function.lambda_python_test.arn
}

# Creates the CloudWatch Log group which will contain the Lambda logs
resource "aws_cloudwatch_log_group" "example" {
  name = "/aws/lambda/${aws_lambda_function.lambda_python_test.function_name}"
}
```
 
</details>
</br>

Run the command below to correct any wrong formatting.

```bash
$ terraform fmt 
```

Review. If no errors are returned, apply.

```bash
$ terraform review 
```
```bash
$ terraform apply -auto-approve 
```

Verify through the AWS Console if the CloudWatch Log group is created. Click the log group to see the log group details and log streams. There's still no log streams here.

![](Images/lab2awscloudwatchloggroup.png)  

----------------------------------------------

### Testing our Setup 

It's time to test what we've built so far. Go to the SQS page and open the **lab2-main-queue**. Click the **Send and receive messages** button at the upper right.

![](Images/lab2testinglambdasqscloudwatch.png)  

Type a message in the **Message Body** field. Change the delivery delay to 0 seconds and then hit **Send message**. It should return a confirmation message.

![](Images/lab2test1.png)  
![](Images/lab2test2.png)  

Send a few more messages.

![](Images/lab2test3.png)  
![](Images/lab2test4.png)  

Go back to the CloudWatch page and hit the refresh button in the **Log streams** section. Click the stream.

![](Images/lab2streamtest1.png)  

If you see the messages you send to the SQS main queue, CONGRATS! 😀

![](Images/lab2stream2.png)  

----------------------------------------------

### References:

- [Write AWS Lambda Logs to CloudWatch Log Group with Terraform](https://stackoverflow.com/questions/59949808/write-aws-lambda-logs-to-cloudwatch-log-group-with-terraform)
- [How to configure AWS Lambda CloudWatch logging with Terraform](https://technotrampoline.com/articles/how-to-configure-aws-lambda-cloudwatch-logging-with-terraform/)
- [How to manage Lambda log groups with Terraform](https://advancedweb.hu/how-to-manage-lambda-log-groups-with-terraform/)

----------------------------------------------

## Lab 03: VPC with EC2 instance

> This lab is based on [Cloud Academy's course on Provisioning AWS Infrastructure.](https://cloudacademy.com/course/terraform-provisioning-aws-infrastructure/course-introduction/?context_resource=lp&context_id=2377)

Before we begin, make sure you've setup the following pre-requisites

  - [Setup Keys and Permissions](#setup-keys-and-permissions)
  - [Setup your Environment and Install Extensions](#setup-your-environment-and-install-extensions)
  - [Configure the Credentials File](#configure-the-credentials-file)
  - [Install Terraform](#install-terraform)

In this lab, we'll create the following:

- a VPC spanning two availability zones
- two public subnets
- internet gateway and a single route table
- a security group
- a t3.micro instance with NGINX installed

![](Images/lab3ex11.png)  


Start with creating the project directory.

```bash
$ mkdir lab03_VPC_with_EC2_Nginx
$ cd lab03_VPC_with_EC2_Nginx
```

### Create the Provider file

Create the provider file.

<details><summary> provider.tf </summary>
 
```bash
 terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = var.my_credentials
  profile                  = var.my_profile
}

```
 
</details>

### Create the Main file

Create the main file which will contain all the core configurations.

<details><summary> main.tf </summary>
 
```bash
# lab03_VPC_with_EC2_Nginx
#--------------------------------------------------------------
# This terraform template deploys a VPC with 2 public subnets
# that has a security group, an internet gateway, and a 
# single route table. 
# An EC2 is also created with Nginx installe.

#--------------------------------------------------------------

# Creates the VPC.
resource "aws_vpc" "lab03-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "lab03-vpc"
  }
}

# Creates the first public subnet.
resource "aws_subnet" "lab03-public-1" {
  vpc_id                  = aws_vpc.lab03-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.avail_zones[0]

  tags = {
    Name = "lab03-public-1"
    Type = "Public"
  }
}

# Creates the second public subnet.
resource "aws_subnet" "lab03-public-2" {
  vpc_id                  = aws_vpc.lab03-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.avail_zones[1]

  tags = {
    Name = "lab03-public-2"
    Type = "Public"
  }
}

# Creates the internet gateway.
resource "aws_internet_gateway" "lab03-gw" {
  vpc_id = aws_vpc.lab03-vpc.id

  tags = {
    Name = "lab03-gw"
  }
}

# Creates the route table.
resource "aws_route_table" "lab03-route-table" {
  vpc_id = aws_vpc.lab03-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab03-gw.id
  }

  tags = {
    Name = "lab03-route-table"
  }
}

# Associates the route table to the first public subnet
resource "aws_route_table_association" "lab03-route-assoc-1" {
  subnet_id      = aws_subnet.lab03-public-1.id
  route_table_id = aws_route_table.lab03-route-table.id
}

# Associates the route table to the second public subnet
resource "aws_route_table_association" "lab03-route-assoc-2" {
  subnet_id      = aws_subnet.lab03-public-2.id
  route_table_id = aws_route_table.lab03-route-table.id
}

# Creates the security group for the EC2-Nginx server.
resource "aws_security_group" "lab03-secgroup-1" {
  name        = "lab03-secgroup-1"
  description = "Allow web server network traffic"
  vpc_id      = aws_vpc.lab03-vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab03-secgroup-1"
  }
}

# Creates the EC2 instance with NGINX installed
resource "aws_instance" "lab03-node-1" {
  instance_type               = var.instance_type
  ami                         = var.amis[var.aws_region]
  key_name                    = aws_key_pair.lab03-keypair.id
  vpc_security_group_ids      = [aws_security_group.lab03-secgroup-1.id]
  subnet_id                   = aws_subnet.lab03-public-1.id
  associate_public_ip_address = true
  user_data                   = file("webserver.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "lab03-node-1"
  }
}

# Imports the keypair
resource "aws_key_pair" "lab03-keypair" {
  key_name   = "lab03-keypair"
  public_key = file("~/.ssh/tf-keypair.pub")
}
```
</details>

### Create the Variables files

Notice that the main.tf has alot of **var.** statements. These reference the variables that are declared in the **variables.tf**. Note that you declare the variables in variables.tf, and you assign values to these variables through the **terraform.tfvars.**

<details><summary> variables.tf </summary>
 
```bash
# Variables for setting up terraform

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "my_credentials" {
  description = "Credentials to be used to connect to AWS"
  type        = list(string)
}

variable "my_profile" {
  description = "Profile to be used to connect to AWS"
  type        = string
}

# Variables for creating the VPC and EC2 instances

variable "instance_type" {
  type = string
}

variable "avail_zones" {
  type = list(string)
}

variable "my_ip" {
  type = string
}

variable "amis" {
  type = map(any)
  default = {
    "ap-southeast-1" : "ami-04d9e855d716f9c99"
    "ap-northeast-1" : "ami-081ce1b631be2b337"
  }
}
```
 
</details>

<details><summary> terraform.tfvars </summary>
 
```bash
# Variables for setting up terraform
aws_region     = "ap-southeast-1"
my_credentials = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
my_profile     = "vscode-dev"

# Variables for creating the VPC and EC2 instances
avail_zones   = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
instance_type = "t3.micro"
```

</details>
</br>

As we will see, we can assign values to the variables in the .tfvars file but we can also assign values throug the commandline as environment variables.

### Create the Outputs file

Next, we'll create the outputs file. These contains the values that will be returned after we run the Terraform template.

<details><summary> outputs.tf </summary>
 
```bash
output "vpc_id" {
  value = aws_vpc.lab03-vpc.id
}

output "public_subnet1_id" {
  value = aws_subnet.lab03-public-1.id
}

output "public_subnet2_id" {
  value = aws_subnet.lab03-public-2.id
}

output "server_public_ip" {
  value = aws_instance.lab03-node-1.public_ip
}
```
 
</details>


### Test it out

Before we proceed, let's get our IP from [whatsmyip.](https://whatismyipaddress.com/). After that, we can assign our IP to a variable which will be used during the execution.

```bash
$ export TF_VAR_my_ip=1.2.3.4/32 
```

Initialize the working directory.

```bash
$ terraform init 
```

To check the environment variables,

```bash
$ set | grep TF_VAR 
```

We can now do a review by running the command below. This will return the expected changes that will be provision once we apply them.

```bash
$ terraform plan 
```

If no errors were returned, then we can now run the Terraform automation.

```bash
$ terraform apply -auto-approve 
```

It should return this message if the run was successful.

```bash
Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

public_subnet1_id = "subnet-0f314a6a058f979e5"
public_subnet2_id = "subnet-036370db7375dbb57"
server_public_ip = "46.137.236.20"
vpc_id = "vpc-01ecb171bd04a12e8"
```

 
Go to the AWS Console and check if the resources are created.

![](Images/lab3awsec2created.png)  
![](Images/lab3awsvpccreated.png)  
![](Images/lab3awssubnetcreated.png)  
![](Images/lab3awsigwcreated.png)  

Now let's test the webserver. Curl the IP. It should return a "200 OK" response.

```bash
$ curl -I 46.137.236.20

HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
Date: Sun, 05 Jun 2022 10:23:40 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Sun, 05 Jun 2022 10:07:14 GMT
Connection: keep-alive
ETag: "629c8052-264"
Accept-Ranges: bytes
```

You can also copy the IP and open it in a browser. You should see the NGINX landing page.

![](Images/lab3awsnginxcreated.png)  

----------------------------------------------

### Cleanup

To delete all the resources, just run the **destroy** command.

```bash
$ terraform destroy -auto-approve 
```

----------------------------------------------

## Lab 04: Advanced VPC with ALB and EC2 instances

> This lab is based on [Cloud Academy's course on Provisioning AWS Infrastructure.](https://cloudacademy.com/course/terraform-provisioning-aws-infrastructure/course-introduction/?context_resource=lp&context_id=2377)

Note that this lab builds on top of the previous lab on "VPC with EC2 instance"

Before we begin, make sure you've setup the following pre-requisites

  - [Setup Keys and Permissions](#setup-keys-and-permissions)
  - [Setup your Environment and Install Extensions](#setup-your-environment-and-install-extensions)
  - [Configure the Credentials File](#configure-the-credentials-file)
  - [Install Terraform](#install-terraform)


In this lab, we'll create the following:

- a VPC spanning two availability zones
- each AZ will have a public and private subnet
- internet gateway and a NAT gateway
- Public and private routes
- a security group
- an Application load BalAncer (ALB)
- autoscaling group of t3.micro instances with NGINX installed

![](Images/lab4diagram.png)  

Start with creating the project directory.

```bash
$ mkdir lab04_Advanced_VPC_ALB_EC2
$ cd lab04_Advanced_VPC_ALB_EC2
```

----------------------------------------------

### Create the Provider file

<details><summary> provider.tf </summary>
 
```bash
terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = var.my_credentials
  profile                  = var.my_profile
}
```
 
</details>

### Create the datasources file

Here we'll define the AMI to be fetched and used for the launch template later.

<details><summary> datasources.tf </summary>
 
```bash

data "aws_ami" "lab04_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}
```
 
</details>

### Create the Main file

<details><summary> main.tf </summary>
 
```bash
# lab04_VPC_with_EC2_Nginx
#---------------------------------------------------------------------
# This terraform template deploys a VPC with 2 public subnets that has 
# a security group, an internet gateway, a NAT gateway, and an 
# Application loadbalancer. Traffic will be loadbalanced between the 
# EC2 instances in the autoscaling group. Finally, the instances are 
# bootstrapped with an NGINX webserver.
#---------------------------------------------------------------------

resource "aws_vpc" "lab04-vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "lab04-vpc"
  }
}

# Creates the first public subnet.
resource "aws_subnet" "lab04-public-subnet-1" {
  vpc_id     = aws_vpc.lab04-vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 1)
  # map_public_ip_on_launch = true
  availability_zone = var.avail_zones[0]

  tags = {
    Name = "lab04-public-subnet-1"
    Type = "Public"
  }
}

# Creates the second public subnet.
resource "aws_subnet" "lab04-public-subnet-2" {
  vpc_id     = aws_vpc.lab04-vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 2)
  # map_public_ip_on_launch = true
  availability_zone = var.avail_zones[1]

  tags = {
    Name = "lab04-public-subnet-2"
    Type = "Public"
  }
}

# Creates the first private subnet.
resource "aws_subnet" "lab04-private-subnet-1" {
  vpc_id            = aws_vpc.lab04-vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone = var.avail_zones[0]

  tags = {
    Name = "lab04-private-subnet-1"
    Type = "Private"
  }
}

# Creates the second private subnet.
resource "aws_subnet" "lab04-private-subnet-2" {
  vpc_id            = aws_vpc.lab04-vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone = var.avail_zones[1]

  tags = {
    Name = "lab04-private-subnet-2"
    Type = "Private"
  }
}

resource "aws_internet_gateway" "lab04-igw" {
  vpc_id = aws_vpc.lab04-vpc.id

  tags = {
    Name = "lab04-igw"
  }
}

# Create the Elastic IP to be used by the NAT gateway.
resource "aws_eip" "lab04-eip-nat" {
  vpc = true
}

# Creates the NAT gateway - Public NAT.
# The NAT gateway is provisioned in the first public subnet
resource "aws_nat_gateway" "lab04-natgw" {
  allocation_id = aws_eip.lab04-eip-nat.id
  subnet_id     = aws_subnet.lab04-public-subnet-1.id

  tags = {
    Name = "lab04-natgw"
  }

  # To ensure proper ordering, it is recommended to add an 
  # explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.lab04-igw]
}

# Creates the route table. One route table per AZ
# This is a public route table that routes to the IGW.
resource "aws_route_table" "lab04-rt-public-1" {
  vpc_id = aws_vpc.lab04-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab04-igw.id
  }

  tags = {
    Name = "lab04-rt-public-1"
  }
}

# This is a private route table that routes to the NAT-GW.
resource "aws_route_table" "lab04-rt-private-2" {
  vpc_id = aws_vpc.lab04-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.lab04-natgw.id
  }

  tags = {
    Name = "lab04-rt-private-2"
  }
}

# Associates the route table to the first public subnet
resource "aws_route_table_association" "lab04-route-assoc-1" {
  subnet_id      = aws_subnet.lab04-public-subnet-1.id
  route_table_id = aws_route_table.lab04-rt-public-1.id
}

# Associates the route table to the second public subnet
resource "aws_route_table_association" "lab04-route-assoc-2" {
  subnet_id      = aws_subnet.lab04-public-subnet-2.id
  route_table_id = aws_route_table.lab04-rt-public-1.id
}

# Associates the route table to the first private subnet
resource "aws_route_table_association" "lab04-route-assoc-3" {
  subnet_id      = aws_subnet.lab04-private-subnet-1.id
  route_table_id = aws_route_table.lab04-rt-private-2.id
}

# Associates the route table to the second private subnet
resource "aws_route_table_association" "lab04-route-assoc-4" {
  subnet_id      = aws_subnet.lab04-private-subnet-2.id
  route_table_id = aws_route_table.lab04-rt-private-2.id
}

# Creates the security group for the autoscaling group of wenservers
# Note that the egress traffic is routed to the ALB.
# This can be seen on the cidr_blocks of the second ingress.
resource "aws_security_group" "lab04-secgroup-1" {
  name        = "lab04-secgroup-1"
  description = "Allow web server network traffic"
  vpc_id      = aws_vpc.lab04-vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from anywhere, through the ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      cidrsubnet(var.cidr_block, 8, 1),
      cidrsubnet(var.cidr_block, 8, 2)
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab04-secgroup-1"
  }
}

# Creates the security group for the ALB
# This allows inbound traffic from the internet and
# allows outbound traffic to go through only the webserber security group
resource "aws_security_group" "lab04-secgroup-2" {
  name        = "lab04-secgroup-2"
  description = "Allow ALB network traffic"
  vpc_id      = aws_vpc.lab04-vpc.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.lab04-secgroup-1.id]
  }

  tags = {
    Name = "lab04-secgroup-1"
  }
}

# Launch template for the autoscaling group
# The "webserver.tpl" bootstraps the instances in the ASG wIth NGINX.
# This uses string interpolation to inject the current module path.
resource "aws_launch_template" "lab04-launchtemplate-webserver" {
  name = "lab04-launchtemplate-webserver"

  image_id               = data.aws_ami.lab04_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.lab04-keypair.id
  vpc_security_group_ids = [aws_security_group.lab04-secgroup-1.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "lab04-webserver"
    }
  }
  user_data = filebase64("${path.module}/webserver.tpl")
}

# Creates the external-facing ALB.
resource "aws_lb" "lab04-alb" {
  name                       = "lab04-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.lab04-secgroup-2.id]
  enable_deletion_protection = false

  subnets = [
    aws_subnet.lab04-public-subnet-1.id,
    aws_subnet.lab04-public-subnet-2.id
  ]

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = {
    Environment = "PRD"
  }
}

resource "aws_lb_target_group" "lab04-alb-target-group" {
  name     = "lab04-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.lab04-vpc.id
}

resource "aws_lb_listener" "lab04-alb-front_end" {
  load_balancer_arn = aws_lb.lab04-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lab04-alb-target-group.arn
  }
}

# Forwards the route path to the target group
resource "aws_lb_listener_rule" "lab04-alb-listener-rule-1" {
  listener_arn = aws_lb_listener.lab04-alb-front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lab04-alb-target-group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

# Creates the ASG of webserver instances.
resource "aws_autoscaling_group" "lab04-asg" {
  name             = "lab04-asg"
  desired_capacity = 2
  max_size         = 5
  min_size         = 2

  target_group_arns = [
    aws_lb_target_group.lab04-alb-target-group.arn
    ]
    
  vpc_zone_identifier = [
    aws_subnet.lab04-private-subnet-1.id,
    aws_subnet.lab04-private-subnet-2.id
  ]
  

  launch_template {
    id      = aws_launch_template.lab04-launchtemplate-webserver.id
    version = "$Latest"
  }
}

# Imports the keypair
resource "aws_key_pair" "lab04-keypair" {
  key_name   = "lab04-keypair"
  public_key = file("~/.ssh/tf-keypair.pub")
}
```
 
</details>
</br>

Notice here we're using **cidrblock** variable which is declared in **variables.tf** and assigned a value in **terraform.tfvars**. We also leveraged **cidrsubnet** function which calculates a subnet within a given IP network address prefix.

### cidrsubnet function

```bash
cidrsubnet(prefix, newbits, netnum) 
```

From the Hashicorp documentation on [cidrsubnet Function:](https://www.terraform.io/language/functions/cidrsubnet):

> This function accepts both IPv6 and IPv4 prefixes, and the result always uses the same addressing scheme as the given prefix.
>
> - **prefix** must be given in CIDR notation, as defined in RFC 4632 section 3.1.
>
> - **newbits** is the number of additional bits with which to extend the prefix. For example, if given a prefix ending in /16 and a newbits value of 4, the resulting subnet address will have length /20.
>
> - **netnum** is a whole number that can be represented as a binary integer with no more than newbits binary digits, which will be used to populate the additional bits added to the prefix.

We can also check the IP by running **console** command.

```bash
$ terraform console
> cidrsubnet(var.cidr_block, 8, 1)
"10.0.1.0/24"
> cidrsubnet(var.cidr_block, 8, 2)
"10.0.2.0/24"
> cidrsubnet(var.cidr_block, 8, 3)
"10.0.3.0/24"
> cidrsubnet(var.cidr_block, 8, 4)
"10.0.4.0/24"
> cidrsubnet(var.cidr_block, 8, 0)
"10.0.0.0/24"
```

### Launch template

From the main.tf, we used a **aws_launch_template** instead of an **aws_instance** resource. Here we define the launch configurations for the instances that will be launched in the auto-scaling group. The template also utilize a **webserver.tpl** template which will bootstrap the EC2 instances with NGINX webserver.

### Validate

But first, initialize the working directory.

```bash
$ terraform init 
```

To correct any formatting errors,

```bash
$ terraform fmt 
```

To validate if our configuration files are valid,

```bash
$ terraform validate 
```

### Test it out

Before we proceed, let's get our IP from [whatsmyip.](https://whatismyipaddress.com/). After that, we can assign our IP to a variable which will be used during the execution.

```bash
$ export TF_VAR_my_ip=1.2.3.4/32 
```

To check the environment variables,

```bash
$ set | grep TF_VAR 
```

Do a "dry-run" of the execution before actually applying the changes.
This will return the list of resources that will be created when the change is actually ran.

```bash
$ terraform plan 
```

If no errors were returned from the **plan** command, run the changes.
This should return a list of output values.

```bash
$ terraform apply -auto-approve 
```

```bash
Apply complete! Resources: 2 added, 1 changed, 0 destroyed.

Outputs:

alb_dns_name = "lab04-alb-716526745.ap-southeast-1.elb.amazonaws.com"
private_subnet1_id = "subnet-0a363c73f6656849a"
private_subnet2_id = "subnet-048ae0b3b75413895"
public_subnet1_id = "subnet-02849a1abd4e3da0b"
public_subnet2_id = "subnet-030bd5c1d9462303b"
vpc_id = "vpc-0e359f5f3a28c047e"
```

Test the ALB by doing a curl on the ALB dns. This should return a "200 OK" response which indicates success. It should also how that the response originated from an NGINX web server.

```bash
$ curl -I lab04-alb-123456789.ap-southeast-1.elb.amazonaws.com

HTTP/1.1 200 OK
Date: Mon, 06 Jun 2022 04:50:40 GMT
Content-Type: text/html
Content-Length: 612
Connection: keep-alive
Server: nginx/1.18.0 (Ubuntu)
Last-Modified: Mon, 06 Jun 2022 04:12:17 GMT
ETag: "629d7ea1-264"
```

Check the resources if they are created through the AWS Console.

![](Images/lab4ec2created.png)  
![](Images/lab4albcreated.png)  
![](Images/lab4albtargetscreated.png)  
![](Images/lab4asgcreated.png)  

----------------------------------------------

## Lab 05: Advanced VPC with ALB and EC2 instances - Simplified

> This lab is based on [Cloud Academy's course on Provisioning AWS Infrastructure.](https://cloudacademy.com/course/terraform-provisioning-aws-infrastructure/course-introduction/?context_resource=lp&context_id=2377)

This is a continuation of the previous lab on **Advanced VPC with ALB and EC2 instances.** In this lab, we'll be simplifying the configuration by using "count meta" argument.

We'll still use the same set of files.

<details><summary> provider.tf </summary>
 
```bash
terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = var.my_credentials
  profile                  = var.my_profile
}

```
 
</details>

<details><summary> variables.tf </summary>
 
```bash
# Variables for setting up terraform

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "my_credentials" {
  description = "Credentials to be used to connect to AWS"
  type        = list(string)
}

variable "my_profile" {
  description = "Profile to be used to connect to AWS"
  type        = string
}

# Variables for creating the VPC and EC2 instances

variable "instance_type" {
  type = string
}

variable "avail_zones" {
  type = list(string)
}

variable "cidr_block" {
  type = string
}

variable "my_ip" {
  type = string
}


```
 
</details>

<details><summary> terraform.tfvars </summary>

```bash
# Variables for setting up terraform
aws_region     = "ap-southeast-1"
my_credentials = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
my_profile     = "vscode-dev"

# Variables for creating the VPC and EC2 instances
avail_zones   = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
instance_type = "t3.micro"
cidr_block    = "10.0.0.0/16" 
```

</details>

As a references, here's the diagram that we'll use.

![](Images/lab5diagram2.png)  

Here's the modified main file.

<details><summary> main.tf </summary>
 
```bash
# lab04_VPC_with_EC2_Nginx
#---------------------------------------------------------------------
# This terraform template deploys a VPC with 2 public subnets that has 
# a security group, an internet gateway, a NAT gateway, and an 
# Application loadbalancer. Traffic will be loadbalanced between the 
# EC2 instances in the autoscaling group. Finally, the instances are 
# bootstrapped with an NGINX webserver.
#---------------------------------------------------------------------

resource "aws_vpc" "lab04-vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "lab04-vpc"
  }
}

# Creates the public subnet 1 and 2
resource "aws_subnet" "lab04-public-subnet" {
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.lab04-vpc.id
  count                   = length(var.avail_zones)
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone       = element(var.avail_zones, count.index)

  tags = {
    Name = "lab04-public-subnet-${element(var.avail_zones, count.index)}"
    Type = "Public"
  }
}

# Creates the private subnet 1 and 2
resource "aws_subnet" "lab04-private-subnet" {
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.lab04-vpc.id
  count                   = length(var.avail_zones)
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index + length(var.avail_zones))
  availability_zone       = element(var.avail_zones, count.index)

  tags = {
    Name = "lab04-private-subnet-${element(var.avail_zones, count.index)}"
    Type = "Public"
  }
}

resource "aws_internet_gateway" "lab04-igw" {
  vpc_id = aws_vpc.lab04-vpc.id

  tags = {
    Name = "lab04-igw"
  }
}

# Create the Elastic IPs per availability zone
resource "aws_eip" "lab04-eip-nat" {
  count = length(var.avail_zones)
  vpc   = true
}

# Creates the NAT gateway - Public NAT.
# This creates a NAT gateway in each availability zone.
resource "aws_nat_gateway" "lab04-natgw" {
  count         = length(var.avail_zones)
  allocation_id = element(aws_eip.lab04-eip-nat.*.id, count.index)
  subnet_id     = element(aws_subnet.lab04-public-subnet.*.id, count.index)

  tags = {
    Name = "lab04-natgw-${element(var.avail_zones, count.index)}"
  }

  # To ensure proper ordering, it is recommended to add an 
  # explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.lab04-igw]
}

#========================================================================
# Creates the route table. One route table per AZ
# This is a public route table that routes to the IGW.
resource "aws_route_table" "lab04-rt-public" {
  vpc_id = aws_vpc.lab04-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab04-igw.id
  }

  tags = {
    Name = "lab04-rt-public"
  }
}

# Associates the route table to the public subnet
resource "aws_route_table_association" "lab04-route-assoc-public" {
  count          = length(var.avail_zones)
  subnet_id      = element(aws_subnet.lab04-public-subnet.*.id, count.index)
  route_table_id = aws_route_table.lab04-rt-public.id
}

#========================================================================
# This is a private route table that routes to the NAT-GW.
resource "aws_route_table" "lab04-rt-private" {
  vpc_id = aws_vpc.lab04-vpc.id
  count  = length(var.avail_zones)

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.lab04-natgw.*.id, count.index)
  }

  tags = {
    Name = "lab04-rt-private-${element(var.avail_zones, count.index)}"
  }
}

# Associates the route table to the subnets
resource "aws_route_table_association" "lab04-route-assoc-private" {
  count          = length(var.avail_zones)
  subnet_id      = element(aws_subnet.lab04-private-subnet.*.id, count.index)
  route_table_id = element(aws_route_table.lab04-rt-private.*.id, count.index)
}
#========================================================================

# Creates the security group for the autoscaling group of wenservers
# Note that the egress traffic is routed to the ALB.
# This can be seen on the cidr_blocks of the second ingress.
resource "aws_security_group" "lab04-secgroup-1" {
  name        = "lab04-secgroup-1"
  description = "Allow web server network traffic"
  vpc_id      = aws_vpc.lab04-vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from anywhere, through the ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      cidrsubnet(var.cidr_block, 8, 1),
      cidrsubnet(var.cidr_block, 8, 2)
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab04-secgroup-1"
  }
}

# Creates the security group for the ALB
# This allows inbound traffic from the internet and
# allows outbound traffic to go through only the webserber security group
resource "aws_security_group" "lab04-secgroup-2" {
  name        = "lab04-secgroup-2"
  description = "Allow ALB network traffic"
  vpc_id      = aws_vpc.lab04-vpc.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.lab04-secgroup-1.id]
  }

  tags = {
    Name = "lab04-secgroup-1"
  }
}

# Launch template for the autoscaling group
# The "webserver.tpl" bootstraps the instances in the ASG wIth NGINX.
# This uses string interpolation to inject the current module path.
resource "aws_launch_template" "lab04-launchtemplate-webserver" {
  name = "lab04-launchtemplate-webserver"

  image_id               = data.aws_ami.lab04_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.lab04-keypair.id
  vpc_security_group_ids = [aws_security_group.lab04-secgroup-1.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "lab04-webserver"
    }
  }
  user_data = filebase64("${path.module}/webserver.tpl")
}

# Creates the external-facing ALB.
resource "aws_lb" "lab04-alb" {
  name                       = "lab04-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.lab04-secgroup-2.id]
  enable_deletion_protection = false
  subnets                    = aws_subnet.lab04-public-subnet.*.id

  tags = {
    Environment = "PRD"
  }
}

resource "aws_lb_target_group" "lab04-alb-target-group" {
  name     = "lab04-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.lab04-vpc.id
}

resource "aws_lb_listener" "lab04-alb-front_end" {
  load_balancer_arn = aws_lb.lab04-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lab04-alb-target-group.arn
  }
}

# Forwards the route path to the target group
resource "aws_lb_listener_rule" "lab04-alb-listener-rule-1" {
  listener_arn = aws_lb_listener.lab04-alb-front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lab04-alb-target-group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

# Creates the ASG of webserver instances.
resource "aws_autoscaling_group" "lab04-asg" {
  name                = "lab04-asg"
  desired_capacity    = 2
  max_size            = 5
  min_size            = 2
  vpc_zone_identifier = aws_subnet.lab04-private-subnet.*.id

  target_group_arns = [
    aws_lb_target_group.lab04-alb-target-group.arn
  ]

  launch_template {
    id      = aws_launch_template.lab04-launchtemplate-webserver.id
    version = "$Latest"
  }
}

# Imports the keypair
resource "aws_key_pair" "lab04-keypair" {
  key_name   = "lab04-keypair"
  public_key = file("~/.ssh/tf-keypair.pub")
}
```
 
</details>
</br>

In here we can see that we now only have two resource **aws_subnet**, one for public and one for private. To understand what's assigned to the variables, we can use the **console** command.

```bash
$ terraform console

> var.avail_zones
tolist([
  "ap-southeast-1a",
  "ap-southeast-1b",
  "ap-southeast-1c",

> cidrsubnet(var.cidr_block, 8, 0)
"10.0.0.0/24"
> cidrsubnet(var.cidr_block, 8, 1)
"10.0.1.0/24"
> cidrsubnet(var.cidr_block, 8, 2)
"10.0.2.0/24"
> cidrsubnet(var.cidr_block, 8, 3)
"10.0.3.0/24"
> cidrsubnet(var.cidr_block, 8, 4)
"10.0.4.0/24"

> element(var.avail_zones, 1)
"ap-southeast-1b"
> element(var.avail_zones, 2)
"ap-southeast-1c"
> element(var.avail_zones, 3)
"ap-southeast-1a"
```

Before running any terraform commands, we need to [assign our IP](https://whatismyipaddress.com/) to a variable. Make sure to append the "/32" after your IP address.

```bash
export TF_VAR_my_ip=1.2.3.4/32 
```

Initialize the working directory.

```bash
$ terraform init 
```

Check if there are errors with the formatting.

```bash
$ terraform fmt 
```

Then check if the config files are valid.

```bash
$ terraform validate 
```

Finally, do a review to check what changes will be introduce when you actually run the template.

```bash
$ terraform plan 
```

If it doesn't return any error, you can now apply it.

```bash
$ terraform apply -auto-approve 
```

It should return the **Apply complete!** message, along with the output values.

```bash
Apply complete! Resources: 6 added, 3 changed, 3 destroyed.

Outputs:

alb_dns_name = "lab04-alb-2074635167.ap-southeast-1.elb.amazonaws.com"
private_cidr_blocks = [
  "10.0.3.0/24",
  "10.0.4.0/24",
  "10.0.5.0/24",
]
private_subnet_id = [
  "subnet-0461d695d3f32a8d7",
  "subnet-073703ca385d90aec",
  "subnet-0b2e94adc05022505",
]
public_cidr_blocks = [
  "10.0.0.0/24",
  "10.0.1.0/24",
  "10.0.2.0/24",
]
public_subnet_id = [
  "subnet-02f1c37fbbe36d1e4",
  "subnet-07d6f6e03c9283169",
  "subnet-06ba41c814e38bd3e",
]
vpc_id = "vpc-03d74d1e4c0e55081"
```

----------------------------------------------

### Verify

Check in the AWS console if the resources are created.
You may also copy the **alb_dns_name** link that's returned when you run the **apply** command and open it in your browser.

```bash
lab04-alb-2074635167.ap-southeast-1.elb.amazonaws.com
```

You should see the splash page for Nginx.

![](Images/lab5nginxwebpage.png)  


----------------------------------------------

### Cleanup

To delete all the resources, just run the **destroy** command.

```bash
$ terraform destroy -auto-approve 
```

----------------------------------------------

## Lab 06: Advanced VPC with Cloud-Native Application

> This lab is based on [Cloud Academy's course on Provisioning AWS Infrastructure.](https://cloudacademy.com/course/terraform-provisioning-aws-infrastructure/course-introduction/?context_resource=lp&context_id=2377)


Before we begin, make sure you've setup the following pre-requisites

  - [Setup Keys and Permissions](#setup-keys-and-permissions)
  - [Setup your Environment and Install Extensions](#setup-your-environment-and-install-extensions)
  - [Configure the Credentials File](#configure-the-credentials-file)
  - [Install Terraform](#install-terraform)
  - [Create the keypair](#create-the-keypair)


### Introduction

In this lab, we'll create the following:

- a VPC spanning two availability zones
- each AZ will have a public and private subnet
- an internet gateway and a NAT gateway
- Public and private routes established
- an Application load BalAncer (ALB) which will loadbalance traffic across
- an autoscaling group of t3.micro instances with NGINX installed, and 
- a Cloud-native application consisting of a front-end and an API,
- a database instance running MongoDB

Here's the diagram as reference.

![](Images/lab6diagram1.png)  

Start with creating the project directory.

```bash
$ mkdir lab06_Advanced_VPC_ALB_Cloud_Native_App
$ cd lab06_Advanced_VPC_ALB_Cloud_Native_App
```

----------------------------------------------

### Create the Provider file and other Config Files

From Hashicorp's documentation on [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs):

> *Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS. You must configure the provider with the proper credentials before you can use it.*

<details><summary> provider.tf </summary>
 
```bash
terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = var.my_credentials
  profile                  = var.my_profile
}
```
 
</details>

In addition to this, we can also create the following files inside the project directory. We'll leave them blank for now as we will be configuring them later.

```bash
$ touch main.tf
$ touch terraform.tfvars
$ touch variables.tf
$ touch datasources.tf
$ touch outputs.tf
```

----------------------------------------------

### Modularize Terraform Configuration files

In the previous labs, we've done all the core configurations in the main.tf file. This is alright if you're building a fairly simple system, but it gets messy (and increasingly long) as you build more and more complex setups.

To keep our main.tf file clutter-free and easy to read, we will utilize [Terraform AWS modules](https://registry.terraform.io/namespaces/terraform-aws-modules) which will help us modularize the parts and keep each one in their respective directories.

Create the **modules** directory and child modules inside it. The modules that we'll be using are:
- application
- bastion
- network
- security
- storage

```bash
$ mkdir -p modules/{application,bastion,network,security,storag
e} 
```

Inside each of the child modules, create the **main.tf**, **outputs.tf**, and **vars.tf**. These will be the core config files for each module.

```bash
$ touch modules/{application,bastion,network,security,storage}/
{main.tf,outputs.tf,vars.tf} 
```

The project directory should now look like this.

```bash
$ tree
├── datasources.tf
├── main.tf
├── modules
│   ├── application
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── vars.tf
│   ├── bastion
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── vars.tf
│   ├── network
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── vars.tf
│   ├── security
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── vars.tf
│   └── storage
│       ├── main.tf
│       ├── outputs.tf
│       └── vars.tf
└── outputs.tf
├── provider.tf
├── terraform.tfvars
└── variables.tf

6 directories, 21 files
```

Let's now create the global **main.tf** file.

<details><summary> main.tf </summary>
 
```bash
#====================================

module "network" {
  source = "./modules/network"

  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
}

#====================================

module "security" {
  source = "./modules/security"

  vpc_id         = module.network.vpc_id
  workstation_ip = var.my_ip

  depends_on = [
    module.network
  ]
}

#====================================

module "bastion" {
  source = "./modules/bastion"

  instance_ami  = var.instance_ami
  instance_type = var.bastion_instance_type
  key_name      = var.key_pair
  subnet_id     = module.network.public_subnets[0]
  sg_id         = module.security.bastion_sg_id

  depends_on = [
    module.network,
    module.security
  ]
}

#====================================

module "storage" {
  source        = "./modules/storage"
  instance_ami  = var.instance_ami
  instance_type = var.db_instance_type
  key_name      = var.key_pair
  subnet_id     = module.network.private_subnets[0]
  sg_id         = module.security.mongodb_sg_id

  depends_on = [
    module.network,
    module.security
  ]
}

#====================================

module "application" {
  source = "./modules/application"

  instance_type   = var.app_instance_type
  key_name        = var.key_pair
  vpc_id          = module.network.vpc_id
  public_subnets  = module.network.public_subnets
  private_subnets = module.network.private_subnets
  webserver_sg_id = module.security.application_sg_id
  alb_sg_id       = module.security.alb_sg_id
  mongodb_ip      = module.storage.private_ip

  depends_on = [
    module.network,
    module.security,
    module.storage
  ]
}
```
</details>
<br>

Notice that in the main file, it references the modules, starting with **network**. Next to it, the **security** module defines the configurations for the security groups.

It's important to note that in the **security** block, there's a **depends_on** block which states that it needs an "output" from the **network** module.

This means that you can only reference values from modules if the module has defined an **output** for that value.

#### Network Module

Looking inside the network module, we inspect the three files. The first one is the main.tf which si where we configure the VPC. 

The modules's main.tf uses variables that are pulled from the global main.tf file. These variables are defined in the module's vars.tf file. Lastly, it also returns output values which are defined in the outputs.tf file.

<details><summary> main.tf </summary>
 
```bash
# Creates the vpc.
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "lab06-vpc"
  cidr = var.cidr_block

  azs             = var.availability_zones
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Name = "lab06-vpc"
  }
}
```

</details>
 
<details><summary> vars.tf </summary>
 
```bash
variable "availability_zones" {}
variable "cidr_block" {}
```

</details>

<details><summary> outputs.tf </summary>
 
```bash
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}
```

</details>
<br>

For more details, check out the Hashicorp documentation on [AWS VPC Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest).


#### Security Module

These contain all the configurations for the security groups. In the module's main.tf file, we can see that we have four security groups:
 
- security group for the bastion 
- security group for the Application load balancer
- security group for the application itself 
- security group for the MongoDB database

We can also see the main.tf file that the security module is dependent on the success of the network module as it references the **vpc_id** output which will be returned by the network module.

<details><summary> main.tf </summary>
 
```bash
resource "aws_security_group" "lab06-sg-bastion" {
  name        = "lab06-sg-bastion"
  description = "bastion network traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "22 from workstation"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.workstation_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow traffic"
  }
}

resource "aws_security_group" "lab06-sg-alb" {
  name        = "lab06-sg-alb"
  description = "alb network traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.lab06-sg-application.id]
  }

  tags = {
    Name = "allow traffic"
  }
}

resource "aws_security_group" "lab06-sg-application" {
  name        = "lab06-sg-application"
  description = "application network traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "80 from alb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
    #security_groups  = [aws_security_group.alb.id]
  }

  ingress {
    description = "8080 from alb"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
    #security_groups  = [aws_security_group.alb.id]
  }

  ingress {
    description     = "22 from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.lab06-sg-bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "application allow traffic"
  }
}

resource "aws_security_group" "lab06-sg-mongodb" {
  name        = "lab06-sg-mongodb"
  description = "mongodb network traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "27017 from application"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    #cidr_blocks      = ["10.0.0.0/16"]
    security_groups = [aws_security_group.lab06-sg-application.id]
  }

  ingress {
    description     = "22 from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.lab06-sg-bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab06-sg-mongodb"
  }
}
```
 
</details>
<br>

Like the previous one, the security module also uses variables which are declared in the vars.tf and returns output values defined in the outputs.tf.

<details><summary> vars.tf </summary>
 
```bash
variable "vpc_id" {}
variable "workstation_ip" {}
```
 
</details>

<details><summary> outputs.tf </summary>
 
```bash
output "application_sg_id" {
  description = "web server sg id"
  value       = aws_security_group.lab06-sg-application.id
}

output "alb_sg_id" {
  description = "alb sg id"
  value       = aws_security_group.lab06-sg-alb.id
}

output "mongodb_sg_id" {
  description = "mongodb sg id"
  value       = aws_security_group.lab06-sg-mongodb.id
}

output "bastion_sg_id" {
  description = "bastion sg id"
  value       = aws_security_group.lab06-sg-bastion.id
}
```
 
</details>

#### Bastion Module

Here we have three config files as well. This module will launch a jumpbox that will allow us to access the instances in the private subnets.

The bastion will be deployed onto the first public subnet which is configured with a security group. The main.tf file defines all the "specs" for the instance. 

Notice that the module is also dependent on the success of the previous two module as it references the **private_subnet** output and **mongodb_sg_id** output from the network and security modules, respectively.

The module's main.tf file uses variables that are defined in the vars.tf. This module also returns the bastion's public IP as output values declared in the outputs.tf.

<details><summary> main.tf </summary>
 
```bash
resource "aws_instance" "lab06-bastion" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true

  tags = {
    Name  = "lab06-bastion"
  }
}
```
 
</details>

<details><summary> vars.tf </summary>
 
```bash
variable "instance_type" {}
variable "key_name" {}
variable "subnet_id" {}
variable "sg_id" {}
variable "instance_ami" {}
```
 
</details>

<details><summary> outputs.tf </summary>
 
```bash
output "public_ip" {
  description = "public ip address"
  value       = aws_instance.lab06-bastion.public_ip
}
```
 
</details>


#### Storage Module

This module defines the configuration of the MongoDB database.From the main.tf file, we can see that this database instance won't be assigned with a public IP (unlike the bastion instance) as seen with the lack of the **associate_public_ip_address** field. This is because the database will be launched on a private subnet.

Note that we only configured a single database instance for our lab purposes only. it is best practice to configure [replicasets](https://www.mongodb.com/docs/manual/replication/#:~:text=A%20replica%20set%20is%20a,nodes%20are%20deemed%20secondary%20nodes.) for the database and the data stored in EBS that's provisioned with IOPS.

<details><summary> main.tf </summary>
 
```bash
resource "aws_instance" "lab06-mongo" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  user_data = filebase64("${path.module}/setup-mongodb.sh")

  tags = {
    Name  = "lab06-mongo"
  }
}
```
 
</details>
</br>

To bootstrap the instance with MongoDB, the module uses **user_data** to run the **setup-mongodb.sh**.

<details><summary> setup-mongodb.sh </summary>
 
```bash
#!/bin/bash

# Download and install mongoDB package
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
apt-get -y update
apt-get install -y mongodb-org

# Configure the conf file
cat > /etc/mongod.conf << EOF
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true

systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

net:
  port: 27017
  bindIp: 0.0.0.0

processManagement:
  timeZoneInfo: /usr/share/zoneinfo
EOF

# Start the mongodb service
echo starting mongo...
systemctl start mongod

echo preparing mongodb data population script...
mkdir -p /tmp/lab06-app
cd /tmp/lab06-app

# Generates a file containing sample data which will populate the DB
cat > db.setup.js << EOF
use langdb;
db.languages.insert({"name" : "csharp", "codedetail" : { "usecase" : "system, web, server-side", "rank" : 5, "compiled" : false, "homepage" : "https://dotnet.microsoft.com/learn/csharp", "download" : "https://dotnet.microsoft.com/download/", "votes" : 0}});
db.languages.insert({"name" : "python", "codedetail" : { "usecase" : "system, web, server-side", "rank" : 3, "script" : false, "homepage" : "https://www.python.org/", "download" : "https://www.python.org/downloads/", "votes" : 0}});
db.languages.insert({"name" : "javascript", "codedetail" : { "usecase" : "web, client-side", "rank" : 7, "script" : false, "homepage" : "https://en.wikipedia.org/wiki/JavaScript", "download" : "n/a", "votes" : 0}});
db.languages.insert({"name" : "go", "codedetail" : { "usecase" : "system, web, server-side", "rank" : 12, "compiled" : true, "homepage" : "https://golang.org", "download" : "https://golang.org/dl/", "votes" : 0}});
db.languages.insert({"name" : "java", "codedetail" : { "usecase" : "system, web, server-side", "rank" : 1, "compiled" : true, "homepage" : "https://www.java.com/en/", "download" : "https://www.java.com/en/download/", "votes" : 0}});
db.languages.insert({"name" : "nodejs", "codedetail" : { "usecase" : "system, web, server-side", "rank" : 20, "script" : false, "homepage" : "https://nodejs.org/en/", "download" : "https://nodejs.org/en/download/", "votes" : 0}});
db.languages.find().pretty();
EOF

until mongo < db.setup.js; do sleep 5; done

echo fin v1.00!
```
 
</details>
</br>

This module also has variables and output values defined in the vars.tf and outputs.tf, respectively.

<details><summary> vars.tf </summary>
 
```bash
variable "instance_type" {}
variable "key_name" {}
variable "subnet_id" {}
variable "sg_id" {}
variable "instance_ami" {}
```
 
</details>

<details><summary> outputs.tf </summary>
 
```bash
output "private_ip" {
  description = "private ip address"
  value       = aws_instance.lab06-mongo.private_ip
}
```
 
</details>


#### Application Module

This module is another important component as this setups the ALBs, Autoscaling group and the application itself.

The application load balancer (ALB) uses two target groups: 
- target group for the frontend webservers - listens to port 80
- target group for the API - listens to port 8080

The ALB is configured to listen on port 8080 and will forward the traffic to the target group based on the configured listener rules. This ensures traffice is loadbalanced across the instances in the auto caling group (ASG).

<details><summary> main.tf </summary>
 
```bash

#====================================

resource "aws_launch_template" "lab06-apptemplate" {
  name = "lab06-application"

  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.webserver_sg_id]
  user_data              = base64encode(data.template_cloudinit_config.config.rendered)

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name  = "lab06-frontend-app"
      Owner = "Eden-Jose"

    }
  }

}

#====================================

resource "aws_lb" "lab06-alb" {
  name               = "lab06-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "Prod"
  }
}

resource "aws_alb_target_group" "lab06-tg-webserver" {
  name     = "lab06-tg-webserver"
  vpc_id   = var.vpc_id
  port     = 80
  protocol = "HTTP"

  health_check {
    path                = "/"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 6
    timeout             = 5
  }
}

resource "aws_alb_target_group" "lab06-tg-api" {
  name     = "lab06-tg-api"
  vpc_id   = var.vpc_id
  port     = 8080
  protocol = "HTTP"

  health_check {
    path                = "/ok"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 6
    timeout             = 5
  }
}

resource "aws_alb_listener" "lab06-listener-front_end" {
  load_balancer_arn = aws_lb.lab06-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.lab06-tg-webserver.arn
  }

  tags = {
    Name = "lab06-listener-front_end"
  }
}

resource "aws_alb_listener_rule" "lab06-listener-frontend_rule1" {
  listener_arn = aws_alb_listener.lab06-listener-front_end.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.lab06-tg-webserver.arn
  }

  tags = {
    Name = "lab06-listener-frontend_rule1"
  }
}

resource "aws_alb_listener_rule" "lab06-listener-api_rule1" {
  listener_arn = aws_alb_listener.lab06-listener-front_end.arn
  priority     = 10

  condition {
    path_pattern {
      values = [
        "/languages",
        "/languages/*",
        "/languages/*/*",
        "/ok"
      ]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.lab06-tg-api.arn
  }

  tags = {
    Name = "lab06-listener-api_rule1"
  }
}

#====================================

resource "aws_autoscaling_group" "lab06-asg" {
  name                = "lab06-asg"
  vpc_zone_identifier = var.private_subnets

  desired_capacity = var.asg_desired
  max_size         = var.asg_max_size
  min_size         = var.asg_min_size

  target_group_arns = [
    aws_alb_target_group.lab06-tg-webserver.arn, 
    aws_alb_target_group.lab06-tg-api.arn
    ]

  launch_template {
    id      = aws_launch_template.lab06-apptemplate.id
    version = "$Latest"
  }
}

```
 
</details>
</br>

The module also depends on the output values returned by the network, security, and storage modules.

In addition to this, we can see that the main file uses some [data sources](https://www.terraform.io/language/data-sources) which allows using data that are defined outside of Terraform or are define by another separate file. We've placed all the data sources in its separate file.

<details><summary> datasources.tf </summary>
 
```bash
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Canonical
  owners = ["099720109477"]
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  #userdata
  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/install-frontend-api.sh")
  }
}

data "aws_instances" "application" {
  instance_tags = {
    Name  = "lab06-frontendApp"
    Owner = "Eden Jose"
  }

  instance_state_names = ["pending", "running"]

  depends_on = [
    aws_autoscaling_group.lab06-asg
  ]
}
```
 
</details>
</br>

The bootstraping process is done within the **template_cloudinit_config** data source. It uses a script to install the frontend application and API onto the instances.

<details><summary> install-frontend-api.sh </summary>
 
```bash
#! /bin/bash
apt-get -y update
apt-get -y install nginx
apt-get -y install jq

# Creates the variables
# ALB_DNS defined where the frontend will forward the API requests to.
# MONGODB_PRIVATEIP defines where the data will be written to
ALB_DNS=${aws_lb.lab06-alb.dns_name}
MONGODB_PRIVATEIP=${var.mongodb_ip}

mkdir -p /tmp/cloudacademy-app
cd /tmp/cloudacademy-app

echo ===========================
echo FRONTEND - download latest release and install...
mkdir -p ./voteapp-frontend-react-2020
pushd ./voteapp-frontend-react-2020
curl -sL https://api.github.com/repos/cloudacademy/voteapp-frontend-react-2020/releases/latest | jq -r '.assets[0].browser_download_url' | xargs curl -OL
INSTALL_FILENAME=$(curl -sL https://api.github.com/repos/cloudacademy/voteapp-frontend-react-2020/releases/latest | jq -r '.assets[0].name')
tar -xvzf $INSTALL_FILENAME
rm -rf /var/www/html
cp -R build /var/www/html
cat > /var/www/html/env-config.js << EOFF
window._env_ = {REACT_APP_APIHOSTPORT: "$ALB_DNS"}
EOFF
popd

echo ===========================
echo API - download latest release, install, and start...
mkdir -p ./voteapp-api-go
pushd ./voteapp-api-go
curl -sL https://api.github.com/repos/cloudacademy/voteapp-api-go/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")) | .browser_download_url' | xargs curl -OL
INSTALL_FILENAME=$(curl -sL https://api.github.com/repos/cloudacademy/voteapp-api-go/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")) | .name')
tar -xvzf $INSTALL_FILENAME
#start the API up...
MONGO_CONN_STR=mongodb://$MONGODB_PRIVATEIP:27017/langdb ./api &
popd

systemctl restart nginx
systemctl status nginx
echo fin v1.00!
```
 
</details>
<br>

In this script, we can see the following lines which pulls the latest frontend release from the Github repo and stores into the NGINX default serving directory.

```bash
echo ===========================
echo FRONTEND - download latest release and install...
mkdir -p ./voteapp-frontend-react-2020
pushd ./voteapp-frontend-react-2020
curl -sL https://api.github.com/repos/cloudacademy/voteapp-frontend-react-2020/releases/latest | jq -r '.assets[0].browser_download_url' | xargs curl -OL
INSTALL_FILENAME=$(curl -sL https://api.github.com/repos/cloudacademy/voteapp-frontend-react-2020/releases/latest | jq -r '.assets[0].name')
tar -xvzf $INSTALL_FILENAME
rm -rf /var/www/html
cp -R build /var/www/html
cat > /var/www/html/env-config.js << EOFF
window._env_ = {REACT_APP_APIHOSTPORT: "$ALB_DNS"}
EOFF
popd 
```

The lines that follow then pulls the latest API release, starts up, and points to the MongoDB's private IP addresses on port 271017.

```bash
echo ===========================
echo API - download latest release, install, and start...
mkdir -p ./voteapp-api-go
pushd ./voteapp-api-go
curl -sL https://api.github.com/repos/cloudacademy/voteapp-api-go/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")) | .browser_download_url' | xargs curl -OL
INSTALL_FILENAME=$(curl -sL https://api.github.com/repos/cloudacademy/voteapp-api-go/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")) | .name')
tar -xvzf $INSTALL_FILENAME
#start the API up...
MONGO_CONN_STR=mongodb://$MONGODB_PRIVATEIP:27017/langdb ./api &
popd 
```

Next, the vars.tf file contains all the variables that will be passed by the global main.tf (this is the main.tf outside of the modules directory) to the modules.

<details><summary> vars.tf </summary>
 
```bash
variable "instance_type" {}
variable "key_name" {}
variable "vpc_id" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "webserver_sg_id" {}
variable "alb_sg_id" {}
variable "mongodb_ip" {}

variable "asg_desired" {
  type    = number
  default = 2
}
variable "asg_max_size" {
  type    = number
  default = 2
}
variable "asg_min_size" {
  type    = number
  default = 2
}
```
 
</details>
<br>

Lastly, the outputs.tf declares the outputs that are returned when the module is ran.

<details><summary> outputs.tf </summary>
 
```bash
output "dns_name" {
  description = "alb dns"
  value       = aws_lb.lab06-alb.dns_name
}

output "private_ips" {
  description = "application instance private ips"
  value       = data.aws_instances.application.private_ips
}
```
 
</details>

----------------------------------------------

### Configure the variables file

Now that we understand the main config file and the modules it uses, there's only two more config file to complete our setup. Since our templates uses a ton of variables, we have to declare them in the variables.tf file

After that, we can then assign the values onto these variables through the terraform.tfvars file.

<details><summary> variables.tf </summary>
 
```bash
# Variables for setting up terraform

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "my_profile" {
  description = "Profile to be used to connect to AWS"
  type        = string
}

variable "my_credentials" {
  description = "Credentials to be used to connect to AWS"
  type        = list(string)
}


# Variables for creating the VPC and EC2 instances

variable "key_pair" {
  description = "Key name"
  type        = string
}

# AMI for bastion and mongodb
variable "instance_ami" {
  type = string
}

variable "bastion_instance_type" {
  type = string
}

variable "app_instance_type" {
  type = string
}

variable "db_instance_type" {
  type = string
}

variable "availability_zones" {
  type = list(any)
}

variable "cidr_block" {
  type = string
}

variable "my_ip" {
  type = string
}
```
 
</details>

<details><summary> terraform.tfvars </summary>
 
```bash
# Variables for setting up terraform
aws_region     = "ap-southeast-1"
my_credentials = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
my_profile     = "vscode-dev"
key_pair       = "tf-user-keypair"

# Variables for creating the VPC and EC2 instances
availability_zones    = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
cidr_block            = "10.0.0.0/16"
bastion_instance_type = "t3.micro"
app_instance_type     = "t3.micro"
db_instance_type      = "t3.micro"

# AMI for bastion and mongodb
# Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
instance_ami = "ami-04d9e855d716f9c99"
```
 
</details>

----------------------------------------------

### Configure the outputs file

One more thing, we have to configure the outputs.tf file with the expected output values that will be returned once we run the template.

<details><summary> outputs.tf </summary>
 
```bash
output "alb_dns" {
  description = "alb dns"
  value       = module.application.dns_name
}

output "bastion_public_ip" {
  description = "bastion public ip"
  value       = module.bastion.public_ip
}

output "application_private_ips" {
  description = "application instance private ips"
  value       = module.application.private_ips
}

output "mongodb_private_ip" {
  description = "mongodb private ip"
  value       = module.storage.private_ip
}
```
 
</details>
</br>

----------------------------------------------

### About the Cloud-native Application

Here are some details about the cloud-native application:

- it allows you to vote for your programming language
- votes are then stored in a MongoDB database (launched on a private subnet)
- data can be called to the frontend through API using Ajax calls 
- this API will then read and write to the MongoDB database.
- the weblayer where the autoscaling group is launched will run both the frontend and API
- the application will be pulling the the latest release from the repo below

The repo for the applications:

- [Frontend application](https://github.com/cloudacademy/voteapp-frontend-react-2020/releases/tag/1.0.21)
- [API](https://github.com/cloudacademy/voteapp-api-go/releases/tag/1.1.8)

----------------------------------------------

### Time to Apply!

But first, let's export our [machine's IP](https://whatismyipaddress.com/) as a variable that'll be use by the Terraform template.

```bash
$ export TF_VAR_my_ip=1.2.3.4/32 
```

Initialize the working directory.

```bash
$ terraform init 
```

Check the formatting of the config files and then verify if the the configurations are syntactically valid.

```bash
$ terraform fmt 
$ terraform validate
```

Next, do a dry-run of the changes before actually applying the changes

```bash
$ terraform plan 
```

If there are no errors, it should return this message

```bash
Plan: 34 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
you run "terraform apply" now.
```

Finally, apply the changes. It should return output values once it's successfully provisioned the resources.

```bash
$ terraform apply -auto-approve 
```
```bash
Apply complete! Resources: 34 added, 0 changed, 0 destroyed.

Outputs:

alb_dns = "lab06-alb-2087422437.ap-southeast-1.elb.amazonaws.com"
application_private_ips = tolist([
  "10.0.102.206",
  "10.0.101.107",
])
bastion_public_ip = "13.212.219.198"
mongodb_private_ip = "10.0.101.232"
```

Do a cURL on the ALB DNS name to check if it will return a "200 OK" response.

```bash
$ curl -I lab06-alb-2087422437.ap-southeast-1.elb.amazonaws.com

HTTP/1.1 200 OK
Date: Sat, 11 Jun 2022 15:21:15 GMT
Content-Type: text/html
Content-Length: 2505
Connection: keep-alive
Server: nginx/1.18.0 (Ubuntu)
Last-Modified: Sat, 11 Jun 2022 15:12:35 GMT
ETag: "62a4b0e3-9c9"
Accept-Ranges: bytes
```

Verify this response by checking the DNS name through a web browser. We can now vote on the language and these votes will be forwarded downstream onto the ALB then to the API target groups.

> *NOTE: As of 2022, there seems to be a bug on the application because it doesn't load the full webpage. As such, we can only test up to this point. The important thing is we're able to provision the resources and deploy the application*

The webpage should look like this.

![](Images/lab6votingappwebpageexpected.png)  

However when I try to open the ALB's DNS name in the browser, I'm getting an incomplete webpage which doesn't display the voting tick boxes for the languages.

![](Images/lab6votingappwebpageincomplete.png)  


**In case the bug in the voting app is resolved**

Tried deploying the applications in different regions, and using different keypairs and API keys but it still doesn't display the "buttons".

In the event that this get resolved in the distant future, here's some ways to further test the application.

1. Inspect the traffic through the browser.

```bash
Click the three dots in the upper right --> More tools --> Developer tools 
```

2. When you vote, a "vote" HTTP request will appear on the lower left. Click the **Header**.

3. Connect to the bastion host then to the mongodb instance

```bash
$ ssh -i "keypair.pem" ubuntu@<public-ip-bastion> 
$ ssh ubuntu@<private-ip-mongodb>
```

4. Run the DB client and check the data stored in it.

```bash
$ mongo

> use langdb
> db.languages.find().pretty()

```

----------------------------------------------

### Cleanup

To delete all the resources, just run the **destroy** command.

```bash
$ terraform destroy -auto-approve 
```

----------------------------------------------

## Lab 07: Installing Terraform on a Windows Server

In this lab, we'll be using Powershell to install Terraform on a Windows Server. Before we start, make sure to [launch a Windows Server through the AWS Console](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/EC2_GetStarted.html). Similarly, you can follow the next step on how to launch a Windows Server.

<!-- ![](Images/lab7diagram2.png)   -->

### Launch a Windows instance

<details><summary> Spin-up an instance </summary>

To launch a Windows instance, go to the [EC2 console](https://console.aws.amazon.com/ec2/) and click **Launch instances**. 

Give your instance a name and choose **Windows** under the **Application and OS Images** section. Click **Confirm changes** in the prompt window.

![](Images/lab7launchec2windows.png)  
![](Images/lab7acceptchanges.png) 

In the **Keypair** section, you can choose to create a new one or use an existing keypair. 

![](Images/lab7editingnetworksettingsorwindowsinstance.png)  

Under the **Network settings**, click edit and choose the default VPC for your region. Make sure **Auto-assign public IP** is set to "Enable". Next, choose **Select existing security group**

Click **Launch instance**.

Note that we need to configure the existing security group to allow RDP connection from our local machine. Select your instance and click the **Security** tab. Click the security group name under the **Security groups**

![](Images/lab7configuresgtoallowrdp.png)  

In the security group page, click the **Edit inbound rules** at the lower right.

![](Images/lab7editinboundrules.png)  

In the **Edit inbound rules** page, click **Add rule** and set the type of the new rule to **RDP** and the source to **My IP**. Click **Save rules**

![](Images/lab7addnewinboundrule.png)  

</details>


### Connect to your instance

<details><summary> Connect to your instance </summary>

Once your Windows instance is up and running, select it and hit **Connect**. Choose the Session Manager and click **Connect.** 

It should open a Powershell terminal in a new tab. 

![](Images/lab7connecttoec2windowsinstance.png)   
![](Images/lab7sessionmanagerconnect.png)  

Note that you can only connect through the Session Manager if you have an SSM agent installed on the instance. Another option is to connect by choosing the **RDP Client**.

```bash
Connection Type --> Connect using RDP client --> Download remote desktop file 
```

To get the password,

```bash 
Password --> Get password --> Browse to your keypair --> Decrypt password
```

![](Images/lab7getpassword.png)  

Open the RDP file that you just downloaded. Click **Connect** and enter the password in the next window. It will return an "identity unverified" warning, click Yes.

![](Images/lab7openrdpfile.png)

![](Images/lab7enterpasswordinrdpfile.png)  

![](Images/lab7connectingidentityunverified.png)  

You should now be able to access the Windows Server. Open a Powershell terminal from the Start menu and proceed with the next step.

</details>

### Install Terraform

In the Powershell terminal, create a new directory where the Terraform binary will be saved.

```bash
mkdir C:\terraform
cd C:\terraform
```

Download the binary zip file and then extract the binary. Remove the zip once the binary is extracted.

```bash
Invoke-WebRequest -Uri https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_windows_amd64.zip -outfile terraform_0.13.4_windows_amd64.zip 
```
```bash
Expand-Archive -Path .\terraform_0.13.4_windows_amd64.zip -DestinationPath .\
```
```bash
rm .\terraform_0.13.4_windows_amd64.zip -Force 
```

To ensure Terraform commands are read when we execute them, we need to add the Terraform binary to the PATH variable. Make sure to update the current session with the newly added variable.

```bash
setx PATH "$env:path;C:\terraform" -m 
```
```bash
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")  
```

Verify the version installed. 

```bash
terraform version
```

### Cleanup

To delete the resources, close the RDP session and go back to the EC2 console. 

```bash
Select your instance --> Instance state --> Terminate instances
```

![](Images/lab7cleanup.png)  

----------------------------------------------

## Lab 08: Deploy DynamoDB and Solve Implicit Dependencies 

> This lab is based on [Cloud Academy's Learning Path on The Infrastructure Developer's Guide to Terraform: AWS Edition.](https://cloudacademy.com/learning-paths/terraform-on-aws-1-2377/)

Before we begin, make sure you've setup the following pre-requisites

  - [Setup Keys and Permissions](#setup-keys-and-permissions)
  - [Setup your Environment and Install Extensions](#setup-your-environment-and-install-extensions)
  - [Configure the Credentials File](#configure-the-credentials-file)
  - [Install Terraform](#install-terraform)

### Introduction

In this lab, we'll be doing the following:

- deploying a DynamoDB database
- understand Terraform's behavior when deploying resources in order
- intentionally cause a dependency issue
- visualize a Terraform configuration file
- resolve the dependency issue

Start with creating the project directory.

```bash
$ mkdir lab07_Install_Terraform_on_Windows_Server
$ cd lab07_Install_Terraform_on_Windows_Server
```

We'll also create the core configuration files which we will populate in the succeeding steps.

```bash
$ touch main.tf 
$ touch provider.tf
$ touch vars.tf
$ touch terraform.tfvars
```

### Create the Provider file

<details><summary> provider.tf </summary>
 
```bash
terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = var.my_credentials
  profile                  = var.my_profile
}
```
 
</details>

### Create the Variable files 

<details><summary> vars.tf </summary>
 
```bash
# Variables for setting up terraform

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "my_credentials" {
  description = "Credentials to be used to connect to AWS"
  type        = list(string)
}

variable "my_profile" {
  description = "Profile to be used to connect to AWS"
  type        = string
}
```
 
</details>

<details><summary> terraform.tfvars </summary>
 
```bash
# Variables for setting up terraform
aws_region     = "ap-southeast-1"
my_credentials = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
my_profile     = "vscode-dev"
```
 
</details>

### Create the Main file 

<details><summary> main.tf </summary>
 
```bash
# lab08 - Deploy a DynamoDB and a table item.
#----------------------------------------------------

resource "aws_dynamodb_table_item" "lab08-ddb-table-item" {
  table_name = "lab08-ddb-table-item"
  hash_key   = "ddbHashKey"

  item = <<ITEM
{
  "ddbHashKey": {"S": "StartTheCountdown"},
  "four": {"N": "44444"},
  "three": {"N": "33333"},
  "two": {"N": "22222"},
  "one": {"N": "11111"}
}
ITEM
}

resource "aws_dynamodb_table" "lab08-ddb-table" {
  name           = "lab08-ddb-table"
  hash_key       = "ddbHashKey"
  read_capacity  = 10
  write_capacity = 10

  attribute {
    name = "ddbHashKey"
    type = "S"
  }
}
```
 
</details>

### Time to Apply!

But first, initialize the working directory.

```bash
$ terraform init 
```

Verify if the config files are correctly formatte and syntactically valid.

```bash
$ terraform fmt 
$ terraform validate 
```

Next, do a dry-run of the changes before actually applying the changes

```bash
$ terraform plan  
```

If it doesn't return an error, run the changes.

```bash
$ terraform apply -auto-approve 
```

Notice that when we try to provision the resources, it now returns a **ResourceNotFoundException** error message.

```bash
│ Error: ResourceNotFoundException: Requested resource not found
│
│   with aws_dynamodb_table_item.lab08-ddb-table-item,
│   on main.tf line 4, in resource "aws_dynamodb_table_item" "lab08-ddb-table-item":
│    4: resource "aws_dynamodb_table_item" "lab08-ddb-table-item" { 
```

### Understanding the Error

Doing a quick Google search, we found what's causing the [ResourceNotFoundException error:](https://stackoverflow.com/questions/40192304/aws-dynamodb-resource-not-found-exception)

> *From the docs it's either you don't have a Table with that name or it is in CREATING status.*
>
> *I would double check to verify that the table does in fact exist, in the correct region, and you're using an access key that can reach it*

This error actually means that the client cannot reach a table in your database. Here's a list of things to look into:

```bash
1. Your database is running
2. Your accessKey and secretKey are valid for the database
3. Your DB endpoint is valid and contains correct protocol ("http://" or "https://"), and correct hostname, and correct port
4. Your table was created in the database.
5. Your table was created in the database in the same region that you set as a parameter in credentials. Optional, because some
database environments (e.g. Testcontainers Dynalite) don't have an incorrect value for the region. And any nonempty region value will be correct 
```

### Visualize the Config file

To troubleshoot the issue, we can use the **terraform graph** command to visualize the configuration file. It will return a DOT-formatted "digraph" output which we can run through an online Graphviz tool. Copy the output.

```bash
$ terraform graph
```
```bash
digraph {
        compound = "true"
        newrank = "true"
        subgraph "root" {
                "[root] aws_dynamodb_table.lab08-ddb-table (expand)" [label = "aws_dynamodb_table.lab08-ddb-table", shape = "box"]
                "[root] aws_dynamodb_table_item.lab08-ddb-table-item (expand)" [label = "aws_dynamodb_table_item.lab08-ddb-table-item", shape = "box"]
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" [label = "provider[\"registry.terraform.io/hashicorp/aws\"]", shape = "diamond"]
                "[root] var.aws_region" [label = "var.aws_region", shape = "note"]
                "[root] var.my_credentials" [label = "var.my_credentials", shape = "note"]
                "[root] var.my_profile" [label = "var.my_profile", shape = "note"]
                "[root] aws_dynamodb_table.lab08-ddb-table (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                "[root] aws_dynamodb_table_item.lab08-ddb-table-item (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_dynamodb_table.lab08-ddb-table (expand)"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_dynamodb_table_item.lab08-ddb-table-item (expand)"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.aws_region"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.my_credentials"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.my_profile"
                "[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)"
        }
}
```

Open [WebGraphviz](http://www.webgraphviz.com/) in your web browser, paste the copied output to the field, and run **Generate graph**. From here we can see that table and table item are being deployed at the same time. 

![](Images/lab8webgraphviz.png)  

This is what's causing the error because the table has to exist first before the table item can be created. 

### Now that we know what the error means

Time to resolve the dependency issue. Under the **aws_dynamodb_table_item** resource block, we can see that it reference **table_name** and **hash_key** from the **aws_dynamodb_table** resource block.

We can use interpolation on these two fields to tell the table item to pull these two values from the **aws_dynamodb_table** resource, which means the first block must wait for the second block to finish. 

```bash
table_name = aws_dynamodb_table.lab08-ddb-table.name
hash_key   = aws_dynamodb_table.lab08-ddb-table.hash_key 
```

Our new main.tf should now look like this. 

<details><summary> main.tf </summary>
 
```bash
# lab08 - Deploy a DynamoDB and a table item.
#----------------------------------------------------

resource "aws_dynamodb_table_item" "lab08-ddb-table-item" {
  table_name = aws_dynamodb_table.lab08-ddb-table.name
  hash_key   = aws_dynamodb_table.lab08-ddb-table.hash_key

  item = <<ITEM
{
  "ddbHashKey": {"S": "StartTheCountdown"},
  "four": {"N": "44444"},
  "three": {"N": "33333"},
  "two": {"N": "22222"},
  "one": {"N": "11111"}
}
ITEM
}

resource "aws_dynamodb_table" "lab08-ddb-table" {
  name           = "lab08-ddb-table"
  hash_key       = "ddbHashKey"
  read_capacity  = 10
  write_capacity = 10

  attribute {
    name = "ddbHashKey"
    type = "S"
  }
}
```
 
</details>
</br>

Apply the changes again. It should now succeed.

```bash
$ terraform apply -auto-approve 
```
```bash
Apply complete! Resources: 1 added, 0 changed, 0 destroyed. 
```

Let's run the **graph** command again and use the output in the online [WebGraphviz](http://www.webgraphviz.com/)

```bash
$ terraform graph

digraph {
        compound = "true"
        newrank = "true"
        subgraph "root" {
                "[root] aws_dynamodb_table.lab08-ddb-table (expand)" [label = "aws_dynamodb_table.lab08-ddb-table", shape = "box"]
                "[root] aws_dynamodb_table_item.lab08-ddb-table-item (expand)" [label = "aws_dynamodb_table_item.lab08-ddb-table-item", shape = "box"]
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" [label = "provider[\"registry.terraform.io/hashicorp/aws\"]", shape = "diamond"]
                "[root] var.aws_region" [label = "var.aws_region", shape = "note"]
                "[root] var.my_credentials" [label = "var.my_credentials", shape = "note"]
                "[root] var.my_profile" [label = "var.my_profile", shape = "note"]
                "[root] aws_dynamodb_table.lab08-ddb-table (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                "[root] aws_dynamodb_table_item.lab08-ddb-table-item (expand)" -> "[root] aws_dynamodb_table.lab08-ddb-table (expand)"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_dynamodb_table_item.lab08-ddb-table-item (expand)"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.aws_region"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.my_credentials"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.my_profile"
                "[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)"
        }
```

![](Images/lab8correcteddigraph.png)  

The new graph should now display the flowchart which shows that implicit dependency is created between the table and table item.

![](Images/lab8newcorrectgraph.png)  


**Comparison of the code**

![](Images/lab8configwrong.png)![](Images/lab8configright.png)  

### Cleanup

To delete all the resources, just run the **destroy** command.

```bash
$ terraform destroy -auto-approve 
```

----------------------------------------------

## Lab 09: Lookup Function and Different Types of Variables

> This lab is based on [Cloud Academy's Learning Path on The Infrastructure Developer's Guide to Terraform: AWS Edition.](https://cloudacademy.com/learning-paths/terraform-on-aws-1-2377/)

Before we begin, make sure you've setup the following pre-requisites

  - [Setup Keys and Permissions](#setup-keys-and-permissions)
  - [Setup your Environment and Install Extensions](#setup-your-environment-and-install-extensions)
  - [Configure the Credentials File](#configure-the-credentials-file)
  - [Install Terraform](#install-terraform)

### Introduction

In this lab, we'll be doing the following:

- deploying a VPC and an EC2 instance
- looking into "lookup" functions
- understanding different type of variables

This is a fairly simple lab and is an iteration of the first few labs, but here we'll checkout how to use the **lookup** function and see what sort of variables can we define in the **vars.tf** file. 

<p align=center>
<img src="Images/lab9diagram.png">
</p>

Start with creating the project directory.

```bash
$ mkdir lab09_Lookup_and_Types_of_Vars
$ cd lab09_Lookup_and_Types_of_Vars
```

We'll also create the core configuration files which we will populate in the succeeding steps.

```bash
$ touch main.tf 
$ touch provider.tf
$ touch vars.tf
$ touch terraform.tfvars
```

### Create the Provider file

<details><summary> provider.tf </summary>

```bash
terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = var.my_credentials
  profile                  = var.my_profile
}
 
```

</details>

### Create the Main file

We can see that the main.tf file is populated with a lot of variables which we'll declare in the variables files. One important thing to notice here is the use of **lookup** function.

The **ami** field is basically looking through the values inside the map-type **ami_ids** and using **os_type** as a filter. If the os_type is given a "Windows" value, it will then check the ami_ids map and see use the AMI ID that is assocciated with a "windows" key.

<details><summary> main.tf </summary>
 
```bash
# lab09-Lookup Function and Different Types of Variables
#--------------------------------------------------------

resource "aws_vpc" "lab09-vpc" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "lab09-subnet" {
  vpc_id            = aws_vpc.lab09-vpc.id
  cidr_block        = var.subnet
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.servername}subnet"
  }
}

resource "aws_instance" "server" {
  ami                    = lookup(var.ami_ids, var.os_type, null)
  instance_type          = var.instance_size
  monitoring             = var.ec2_monitoring
  vpc_security_group_ids = [aws_vpc.lab09-vpc.default_security_group_id]
  subnet_id              = aws_subnet.lab09-subnet.id
  root_block_device {
    delete_on_termination = var.disk.delete_on_termination
    encrypted             = var.disk.encrypted
    volume_size           = var.disk.volume_size
    volume_type           = var.disk.volume_type
  }
  tags = {
    Name = var.servername
  }
}
```
 
</details>

### Create the variable files

Here we can see that the vars.tf file declares alot of variables. The first three is what we'll use to connect from our local machine to our AWS account

The **availability_zone**, **cidr_block**, **servername**, **subnet**, and **os_type** are all string-type variables. On the other hand, **ec2_monitoring** is a bool-type variable, which means it will only accept True or False.

The **disk** is an object-type variable which allows grouping of values with different types together. This can be see when we assign the value to this variable in the terraform.tfvars file.

The **ami_ids** is a map-type variable which consists of a key-value pair.

<details><summary> vars.tf </summary>
 
```bash
# Variables for setting up terraform

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "my_profile" {
  description = "Profile to be used to connect to AWS"
  type        = string
}

variable "my_credentials" {
  description = "Credentials to be used to connect to AWS"
  type        = list(string)
}

# variables for the lab

variable "availability_zone" {
  description = "Availability zone"
  type        = string
}

variable "cidr_block" {
  description = "IP Range"
  type        = string
}

variable "servername" {
  description = "Name of the server"
  type        = string
}

variable "subnet" {
  description = "subnet IP address space"
  type        = string
}

variable "os_type" {
  description = "OS to deploy, Linux or Windows"
  type        = string
}

variable "ec2_monitoring" {
  description = "Configure monitoring on the EC2 instance"
  type        = bool
}

variable "disk" {
  description = "OS image to deploy"
  type = object({
    delete_on_termination = bool
    encrypted             = bool
    volume_size           = string
    volume_type           = string
  })
}

variable "ami_ids" {
  type        = map(any)
  description = "AMI ID's to deploy"
}

variable "instance_size" {
  description = "Size of the EC2 instance"
  type        = string
  default     = "t2.micro"
}
```
</details>
</br>

Now that we've declared the variables, we can assign values to them through the terraform.tfvars.

<details><summary> terraform.tfvars </summary>
 
```bash
# Variables for setting up terraform
aws_region     = "ap-southeast-1"
my_credentials = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
my_profile     = "vscode-dev"

# Variables for the lab
cidr_block        = "10.0.0.0/16"
availability_zone = "ap-southeast-1a"
servername        = "lab09-server"
subnet            = "10.0.1.0/24"
os_type           = "linux"
ec2_monitoring    = true

disk = {
  delete_on_termination = false
  encrypted             = true
  volume_size           = "20"
  volume_type           = "standard"
}

ami_ids = {
  linux   = "ami-04d9e855d716f9c99"
  windows = "ami-07d9bd7bc4f2370d0"
}
```

</details>

### Time to Apply!

Initialize the working directory.

```bash
$ terraform init 
```

Check if there are errors with the formatting.

```bash
$ terraform fmt 
```

Then check if the config files are valid.

```bash
$ terraform validate 
```

Finally, do a review to check what changes will be introduce when you actually run the template.

```bash
$ terraform plan 
```

If it doesn't return any error, you can now apply it.

```bash
$ terraform apply -auto-approve 
```

It should return the **Apply complete!** message, along with the output values.

```bash
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

Verify in the AWS Console if the resources are provisioned.

![](Images/lab9ec2created.png)  


### Cleanup

To delete all the resources, just run the **destroy** command.

```bash
$ terraform destroy -auto-approve 
```

----------------------------------------------

## Lab 10: Create an ECR Resource and Use Provisioners

----------------------------------------------

## Lab 11: Deploy an S3 Bucket


```bash
$ mkdir lab11_Deploy_S3_Bucket
$ cd lab11_Deploy_S3_Bucket
```

----------------------------------------------
----------------------------------------------
----------------------------------------------
----------------------------------------------

## Pre-requisites

There are a couple of must-dos before we can start the labs. 

<details><summary> If you're using AWS </summary>

### Setup Keys and Permissions

Login to your AWS Console and go to IAM. Create a new user named **tf-eden**

```bash
1. IAM --> Users --> Add user 
2. Add username --> Tick the "Access key - Programmatic Access" --> Next: permissions
3. Select "Attach existing policies directly" --> Tick "Administrator Access" --> Next: Tags
4. Key: "Name", Value: "tf-user" --> Next: Review
5. Create User
```

Once user is created, you should now see the user name, access key ID, and Secret access key. Click the **Download .csv**

![](Images/builddevaws1.png)  

Next step is to create the credentials file. You can do this after installing the extensions.

----------------------------------------------

### Setup your Environment and Install Extensions 

For this one, I'm using VS Code. We'll set it up with the following extensions:

- AWS Toolkit Extension
- Terraform Extension

####  AWS Toolkit Extension

Click the View tab and then Extensions. In the search bar, type in the extension name.

![](Images/tfextension-aws.png)  

Once installed, you should see the the AWS icon on the left panel and **Connect to AWS** in the Explorer tab. 

####  Terraform Extension

In the Extensions panel of VSCode, search for the Terraform extension. There's an official extension from Hashicorp but it is still buggy during the creation of this notes thus I suggest to install the extension from Anton Kulikov.

![](Images/tfextension1.png)  

Finally, create your working directory. For this lab, I called my working directory "lab01_build_dev_env".

----------------------------------------------

### Configure the Credentials File

After you've installed the extension, you will need to configure the credentials profile. This will allow you to connect to your AWS account.

```bash
View --> Command Palette --> AWS: Create Credentials Profile
```

Populate the credentials file with the AWS Access key and secret access key from the CSV file you just downloaded earlier. 

![](Images/tfcredentials.png)  


```bash
# Amazon Web Services Credentials File used by AWS CLI, SDKs, and tools
# This file was created by the AWS Toolkit for Visual Studio Code extension.
#
# Your AWS credentials are represented by access keys associated with IAM users.
# For information about how to create and manage AWS access keys for a user, see:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html
#
# This credential file can store multiple access keys by placing each one in a
# named "profile". For information about how to change the access keys in a 
# profile or to add a new profile with a different access key, see:
# https://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html 
#
[vscode-dsv]
# The access key and secret key pair identify your account and grant access to AWS.
aws_access_key_id = AKIA4LE56APQJ3J75I7T
# Treat your secret key like a password. Never share your secret key with anyone. Do 
# not post it in online forums, or store it in a source control system. If your secret 
# key is ever disclosed, immediately use IAM to delete the access key and secret key
# and create a new key pair. Then, update this file with the replacement key details.
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Click the AWS icon on the left panel again. This should open the **Explorer tab**. Here, click **Connect to AWS** and select the credentials profile you created. It will prompt you use US-East-1 as default region. Select Yes for now.

To add another region, click the three dots at the Explorer tab and select **Show or hide regions**. We'll use Singapore region for this lab.

![](Images/tfshowhideregions.png)  
![](Images/tfshowregionssingapore.png) 

----------------------------------------------

### Install Terraform on Linux

To install Terraform, we can use the official documentation from Hashicorp which can be accessed through the first link below. Similarly, you can also follow the second link to install Terraform through WSL.

- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

- [Configuring Terraform on Windows 10 Linux Sub-System](https://techcommunity.microsoft.com/t5/azure-developer-community-blog/configuring-terraform-on-windows-10-linux-sub-system/ba-p/393845)

For the second link, here's a summary of commands. 

```bash
sudo apt-get update 
sudo apt-get upgrade 
sudo apt-get install unzip 
```

You need to get the most recent download URL from the Terraform [download page](https://www.terraform.io/downloads) first before unzipping the file. Since you're running WSL on a Windows machine, right-click on any of the available packages for Linux.

```bash
wget <terraform_url> -O terraform.zip;
```

```bash
wget https://releases.hashicorp.com/terraform/1.2.1/terraform_1.2.1_windows_386.zip \
-O terraform.zip
```
```bash
unzip terraform.zip;
rm terraform.zip; 
```

Verify.
```bash
$ terraform -v 
```

----------------------------------------------

### Install Terraform on a Windows Server

There is a lab dedicated to [installing Terraform on a Windows Server using Powershell](#lab-07-installing-terraform-on-a-windows-server).

----------------------------------------------

### Install AWS CLI and Configure with the Credentials

This part is optional since some labs will use the credentials files or the environment variables for the API keys and secrets.

For labs that do require the AWS CLI, you can easily install it by opening WSL and running the commands below

```bash
$ sudo apt-get update
$ sudo apt install -y awscli
```

Verify the version.

```bash
$ aws --version

aws-cli/1.18.69 Python/3.8.10 Linux/5.10.102.1-microsoft-standard-WSL2 botocore/1.16.19
```

If you're using other OS, you can check out the [Resources](#resources) section below to know more.

To configure our AWS CLI with credentials, run the command below. Paste the access key and the secret key when prompted. This is the same key and secret that you got from the [Setup your Environment and Install Extensions](#setup-your-environment-and-install-extensions) section.

```bash
$ aws configure

AWS Access Key ID [None]: AKIA12345678910
AWS Secret Access Key [None]: ***************
Default region name [None]: ap-southeast-1
Default output format [None]: 
```

You can then choose a default region. For this lab, we'll be using ap-southeast-1 (Singapore.)

----------------------------------------------

### Create the keypair

We will also need a keypair to connect to our EC2 instances. You can create the keypair through any of the following methods.

- [Create key pairs through the AWS Console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html)
- [Create key pairs through the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-services-ec2-keypairs.html)


</details>


<!-- <details><summary> If you're using Azure </summary>


</details> -->

----------------------------------------------

## Resources

- [Terraform 1.0 - Provisioning AWS Infrastructure](https://cloudacademy.com/course/terraform-provisioning-aws-infrastructure/course-introduction/?context_resource=lp&context_id=2377)
- [Hands-On Infrastructure Automation with Terraform on AWS](https://github.com/PacktPublishing/Hands-on-Infrastructure-Automation-with-Terraform-on-AWS)
- [Implementing Terraform with AWS](https://www.pluralsight.com/courses/implementing-terraform-aws)
- [Applying Graph Theory to Infrastructure as Code](https://www.youtube.com/watch?v=Ce3RNfRbdZ0)
- [AWS DynamoDB resource not found exception](https://stackoverflow.com/questions/40192304/aws-dynamodb-resource-not-found-exception)
- [Installing or updating the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)