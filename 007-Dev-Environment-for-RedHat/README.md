
# Lab 004: Dev Environment for Red Hat Labs


- [Introduction](#introduction)
- [Pre-requisites](#pre-requisites)
- [Create a Keypair on your Terminal](#create-a-keypair-on-your-terminal)
- [A Few Reminders](#a-few-reminders)
- [How to use this repo](#how-to-use-this-repo)
- [Outputs](#outputs)
- [Remote Development](#remote-development)
- [Cleanup](#cleanup)


## Introduction

This is an iteration of "Lab 001-DEV Environment in AWS" but this particular lab is to provision resources for RedHat labs.

For a deep dive of the different configuration files, please check out the "Lab 001".

Local environment used for this lab. 

- Windows machine/laptop
- Visual Studio Code v1.67.2 (VSCode)
- WSL on Visual Studio Code
- Amazon Web Services (AWS) resources

## Pre-requisites 

- [Setup Keys and Permissions](../README.md#pre-requisites)
- [Setup your Local Environment and Install Extensions](../README.md#pre-requisites) 
- [Configure the Credentials File](../README.md#pre-requisites) 
- [Install Terraform](../README.md#pre-requisites) 
         

## Create a Keypair on your Terminal

In your terminal, generate a keypair. You will use this later to connect to your instance. Make sure to name your keypair **tst-keypair** as this is the name of the keypair defined in the code.

```bash
$ ssh-keygen -t ed25519

Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/joseeden/.ssh/id_ed25519): ~/.ssh/tst-keypair  
```

Some sidenote: If you are using WSL2 on Windows, you could have two actual ".ssh" directory locations.

- "/home/username/.ssh"
- "/mnt/c/User/username/.ssh"

This could cause some issue when you try to connect your VSCode to the remote instance via SSH since VSCode will be looking for the keypair in the "/mnt/c/.." directory while your key is in "/home/username/.ssh".

As a workaround, make sure that the key is present in both directories.

## A Few Reminders

A few reminders about this automation:

- This will provision a VPC and an EC2 instance in ap-southeast-1 (Singapore) region
- The VPC will be assigned a "10.123.0.0/16" CIDR block
- This will provision an EC2 instance with "t2.medium" instance type
- The instance will automatically be assigned with a public IP during launch
- The instance will be launched on the first availability zone of the assigned region

You can change this options by editing the **terraform.tfvars**. Note that if you want to launch the resources in a different region, you will need to:

- Change the aws_region variable and specify the avail_zone in variable.tf
- Comment out the "ami" in main.tf and uncomment the "ami = var.aws_ami" below it 
- Uncomment the variable block for "aws_ami" in the variable.tf file and specify the AMI ID in the default field


## How to use this repo

Clone this repo.

```bash
git clone https://github.com/joseeden/All-Things-Terraform.git
```

Go to lab directory.

```bash
cd Lab_004_Dev_Environment_for_RedHat
```

Initialize this directory.

```bash
terraform init  
```

If you get a "_does not match configured version constraint_" error, just add the "upgrade" argument.

```bash
terraform init -upgrade 
```

Verify the formatting and check if the config files are syntactically valid.

```bash
terraform fmt 
terraform validate 
```

Before we proceed, get your [computer's IP](https://whatismyipaddress.com/) and export it as a variable on the command line. Make sure to add the "/32" at the end.

```bash
export TF_VAR_my_ip=1.2.3.4/32
```

Another way to get your IP is through the terminal.

```bash
curl ipecho.net/plain 
```

We can then pass this to the variable.

```bash
export TF_VAR_my_ip=$(curl ipecho.net/plain) 
```

Verify.

```bash
echo $TF_VAR_my_ip 
```

Do a preview of the changes before actually applying them. This makes sure we catch any possible error before we actually run the automation. 

```bash
terraform plan 
```

If it doesn't return any errors, apply the changes.

```bash
terraform apply -auto-approve 
```


## Outputs 

After successfully provisioning the resource, it returns a public IP. You may go to the AWS Console and verify if it's the same public IP on the EC2 instance.

```bash
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

tst-node-1-ip = "4.5.6.7"
```

## Remote Development

This automation also sets up your VSCode for remote development. You will need to download the [Remote-SSH extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack). There shold be an additional icon for Remote-SSH in the left panel of VSCode. 

Once you click it, you should see the IP of your instance there. Right-click, then "Connect to Host in New Window"

Next, click Linux.

When prompted "if you want to proceed", choose Continue.

Once connected, you should now be able to open the files in the instance through VSCode.

## Cleanup

To delete all the resources, just run the **destroy** command.

```bash
$ terraform destroy -auto-approve 
```
