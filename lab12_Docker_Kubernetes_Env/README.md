
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
 
### Configure the Credentials on your Laptop

Follow these steps to [configure the Credentials File](../README.md#pre-requisites)   
 
</details>


### Create a Keypair on the AWS Console

In your terminal, generate a keypair. You will use this later to connect to your instance. Make sure to name your keypair **tst-keypair** as this is the name of the keypair defined in the code

```bash
$ ssh-keygen -t ed25519

Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/joseeden/.ssh/id_ed25519): ~/.ssh/tst-keypair  
```

### A Few Reminders

A few reminders about this automation:
- this will provision a VPC and an EC2 instance in ap-southeast-1 (Singapore) region
- the VPC will be assigned a "10.123.0.0/16" CIDR block
- this will provision an EC2 instance with "t2.medium" instance type
- the instance will automatically be assigned with a public IP during launch
- the instance will be launched on the first availability zone of the assigned region

You can change this options by editing the **terraform.tfvars**. Note that if you want to launch the resources in a different region, you will need to:
- change the aws_region variable and specify the avail_zone in variable.tf
- comment out the "ami" in main.tf and uncomment the "ami = var.aws_ami" below it 
- uncomment the variable block for "aws_ami" in the variable.tf file and specify the AMI ID in the default field


### Enough Talk. How do I use this repo?

Clone this repo.

```bash
$ git clone https://github.com/joseeden/101-Terraform-Projects.git 
```

Go to Lab 12.

```bash
$ cd lab12_Docker_Kubernetes_Env
```

Initialize this directory.

```bash
$ terraform init  
```

If you get a "_does not match configured version constraint_" error, just add the "upgrade" argument.

```bash
$ terraform init -upgrade 
```

Verify the formatting and check if the config files are syntactically valid.

```bash
$ terraform fmt 
$ terraform validate
```

Before we proceed, get you [computer's IP](https://whatismyipaddress.com/) and export it as a variable on the command line. Make sure to add the "/32" at the end.

```bash
$ export TF_VAR_my_ip=1.2.3.4/32
```

Do a preview of the changes before actually applying them. This makes sure we catch any possible error before we actually run the automation. 

```bash
$ terraform plan 
```

If it doesn't return any errors, apply the changes.

```bash
$ terraform apply -auto-approve 
```

### Outputs 

Notice that after successfully provisioning the resource, it returns a public IP. You may go to the AWS Console and verify if it's the same public IP on the EC2 instance.

```bash
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

tst-node-1-ip = "4.5.6.7"
```

On your terminal, go to the directory where you saved the keypair and use it to SSH to your instance.

```bash
$ cd ~/.ssh
$ ssh -i "tst-keypair.pem" ubuntu@4.5.6.7
```

Once your logged-in, verify the version of docker installed.

```bash
$ docker version  
```

Run a simple "hello-world" container.

```bash
$ sudo docker run hello-world  
```

You should get an output like this:

<details><summary> Hello from Docker! </summary>
 
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
 
</details>
</br>

Go celebrate, lad. You just run a simple container.
As a bonus, here's a nyancat for you.

```bash
$ sudo docker run -it --rm --name nyancat 06kellyjac/nyancat 
```


### Oh, Another thing - Remote Development

This automation also sets up your VSCode for remote development. Download the [Remote-SSH extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack). There shold be an additional icon for Remote-SSH in the left panel of VSCode. 

Once you click it, you should see the IP of your instance there. Right-click, then "Connect to Host in New Window"

Next, click Linux.
When prompted if you want to proceed, choose Continue.

Once connected, you should now be able to open the files in the instance through VSCode.

### Cleanup

Alright. Time to wrap up. Let's make sure we won't be surprised by unexpected charges in our billing statement.

To delete all the resources, just run the **destroy** command.

```bash
$ terraform destroy -auto-approve 
```
