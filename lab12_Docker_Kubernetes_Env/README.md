
## Lab 12: Deploy an Instance for Docker and Kubernetes Lab

### Introduction

This is an iteration of "Lab 01-Build a DEV Environment with Terraform and AWS" but this particular lab is to provision a resource for doing Docker and Kubernetes labs.

This is not a intended to explain the different configuration files. You can check out the "Lab 01" to do a deep dive.

Before we start, here are the tools that I am using for this lab.
- Windows machine/laptop
- Visual Studio Code v1.67.2 (VSCode)
- WSL on Visual Studio Code
- Amazon Web Services (AWS) resources

If you've installed Terraform before and have setup your IDE with the necessary extensions, you can skip to the "Authentication" and "Configure the Credentials" steps

<details><summary> Install Terraform </summary>

### Install Terraform

Follow these steps to [install Terraform.](../README.md#pre-requisites)
 
</details>

<details><summary> Setup Local Environment </summary>

### Setup Local Environment 
 
For this one, I'm using VS Code. We'll set it up with the following extensions:

- AWS Toolkit Extension
- Terraform Extension

Follow these steps to [setup your Visual Studio Code.](../README.md#pre-requisites)  
 
</details>

<details><summary> Authentication </summary>
 
### Authentication

Follow these steps to [create the API keys and the credentials file locally.](../README.md#pre-requisites)    
 
</details>

<details><summary> Configure the Credentials </summary>
 
### Configure the Credentials

Follow these steps to [configure the Credentials File](../README.md#pre-requisites)   
 
</details>


### Create a Keypair

In your terminal, generate a keypair. You will use this later to connect to your instance. Make sure to name your keypair **tst-keypair** as this is the name of the keypair defined in the code

```bash
$ ssh-keygen -t ed25519

Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/joseeden/.ssh/id_ed25519): /home/joseeden/.ssh/tf-keypair  
```

### Variables

A few notes about this automation:
- this will provision a VPC and an EC2 instance in ap-southeast-1 (Singapore) region
- the VPC will be assigned a "10.123.0.0/16" CIDR block
- this will provision an EC2 instance with "t2.medium" instance type
- the instance will automatically be assigned with a public IP during launch
- the instance will be launched on the first availability zone of the assigned region

You can change this options by editing the **variables.tf**. Note that if you want to launch the resources in a different region, you will need to:
- change the aws_region variable and specify the avail_zone in variable.tf
- comment out the "ami" in main.tf and uncomment the "ami = var.aws_ami" below it 
- uncomment the variable block for "aws_ami" in the variable.tf file and specify the AMI ID in the default field

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

### Cleanup

To delete all the resources, just run the **destroy** command.

```bash
$ terraform destroy -auto-approve 
```
----------------------------------------------

### References:

- [Github - morethancertified/rfp-terraform](https://github.com/morethancertified/rfp-terraform)
