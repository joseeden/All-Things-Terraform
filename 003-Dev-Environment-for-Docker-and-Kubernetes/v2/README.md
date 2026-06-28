
# Lab 003: Dev Environment for Docker and Kubernetes

- [Introduction](#introduction)
- [Pre-requisites](#pre-requisites)
- [Create a Keypair](#create-a-keypair)
- [A Few Reminders](#a-few-reminders)
- [How to use this repo](#how-to-use-this-repo)
- [Outputs](#outputs)
- [Verify Docker Installation](#verify-docker-installation)
- [Remote Development](#remote-development)
- [Cleanup](#cleanup)


## Introduction

This is an iteration of "Lab 001-DEV Environment in AWS" but this particular lab is to provision a resource for Docker and Kubernetes labs.

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
              

## Create a Keypair

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

Go to the lab directory.

```bash
cd Lab_003_Dev_Environment_for_Docker_and_Kubernetes
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

After successfully provisioning the resource, it returns a public IP. You may go to the AWS Console and verify if it's the same public IP on the EC2 instances.

```bash
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

node-master-ip = "11.123.123.123"
node-worker1-ip = "13.124.123.123"
node-worker2-ip = "15.123.124.123"
node-worker3-ip = "14.123.123.124"
```

## Verify Docker Installation 

On your terminal, go to the directory where you saved the keypair and use it to SSH to your instance.

```bash
cd ~/.ssh
ssh -i "tst-keypair.pem" ubuntu@4.5.6.7
```

Once your logged-in, verify the version of docker installed.

```bash
docker version  
```

Run a simple "hello-world" container.

```bash
sudo docker run hello-world  
```

You should get an output like this:

```bash
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

Go celebrate, lad. You just run a simple container.
As a bonus, here's a nyancat for you.

```bash
sudo docker run -it --rm --name nyancat 06kellyjac/nyancat 
```

## Remote Development

This automation also sets up your VSCode for remote development. You will need to download the [Remote-SSH extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack). There should be an additional icon for Remote-SSH in the left panel of VSCode. 

Once you click it, you should see the IP of your instance there. Right-click, then "Connect to Host in New Window"

Next, click Linux.
When prompted if you want to proceed, choose Continue.

Once connected, you should now be able to open the files in the instance through VSCode.

## Cleanup

Alright. Time to wrap up. Let's make sure we won't be surprised by unexpected charges in our billing statement.

To delete all the resources, just run the **destroy** command.

```bash
$ terraform destroy -auto-approve 
```
