
# 101 Terraform Projects

This repository contains all the Terraform projects that I've worked on and I'm currently working on. The goal is "terraforming" different deployments that includes:

- Provisioning AWS resources
- Provisioning Azure resources
- Provisioning GCP resources
- Amazon EKS clusters
- Confluent Cloud resources
- Terraform tied up with Ansible and Jenkins

Before we begin, make sure to go through some of the pre-requisites that you need to install on your local machine.

## Pre-requisites

There are a couple of must-dos before we can start the labs. 

If you're using AWS:

<details><summary> Setup Keys and Permissions </summary>

### Setup Keys and Permissions

Login to your AWS Console and go to IAM. You can choose a different username. I'm creating a user called **tf-eden**.

```bash
1. IAM --> Users --> Add user 
2. Add username --> Tick the "Access key - Programmatic Access" --> Next: permissions
3. Select "Attach existing policies directly" --> Tick "Administrator Access" --> Next: Tags
4. Key: "Name", Value: "tf-user" --> Next: Review
5. Create User
```

Once user is created, you should now see the user name, access ky ID, and Secret access key. Click the **Download .csv**

![](Images/builddevaws1.png)  

Next step is to create the credentials file. You can do this after installing the extensions.

</details>

<details><summary> Setup your Environment and Install Extensions </summary>

### Setup your Environment and Install Extensions 

For this one, I'm using VS Code. We'll set it up with the following extensions:

- AWS Toolkit Extension
- Terraform Extension

#### AWS Toolkit Extension

Click the View tab and then Extensions. In the search bar, type in the extension name.

![](Images/tfextension-aws.png)  

Once installed, you should see the the AWS icon on the left panel and **Connect to AWS** in the Explorer tab. 

#### Terraform Extension

In the Extensions panel of VSCode, search for the Terraform extension. There's an official extension from Hashicorp but it is still buggy during the creation of this notes thus I suggest to install the extension from Anton Kulikov.

![](Images/tfextension1.png)  

Finally, create your working directory. For this lab, I called my working directory "lab01_build_dev_env".

</details>

<details><summary> Configure the Credentials File </summary>

### Configure the Credentials File

After you've installed the extension, you will need to configure the credentials profile. This will allow you to connect to your AWS account.

```bash
View --> Command Palette --> AWS: Create Credentials Profile
```

Populate the credentials file with the AWS Access key and secret access key from the CSV file you just downloaded earlier.  

![](Images/tfcredentials.png)  


The credentials file should be created with the text below. 

<details><summary> credentials </summary>
 
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
</details>
<br>

If it doesn't exist, you can simply create a **credentials** file and put in the profile, access key and secret access key. For this one, I named the profile **vscode-dev** but you can call it whatever you like.

```bash
[vscode-dev]
aws_access_key_id = AKIA4LE56APQJ3J75I7T
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Back in the Explorer tab, click **Connect to AWS** and select the credentials profile you created. It will prompt you use US-East-1 as default region. Select Yes for now.

To add another region, click the three dots at the Explorer tab and select **Show or hide regions**. We'll use Singapore region for this lab.

![](Images/tfshowhideregions.png)  
![](Images/tfshowregionssingapore.png) 

</details>

### Install Terraform on Linux

To install Terraform, we have these options:

- we can use the [official documentation from Hashicorp](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- install Terraform through [WSL](https://techcommunity.microsoft.com/t5/azure-developer-community-blog/configuring-terraform-on-windows-10-linux-sub-system/ba-p/393845)
- run the [setup-terraform.sh](./setup-terraform.sh) script

After installing, verify.
```bash
$ terraform -v 
```

### Install Terraform on Windows

There is a lab dedicated to [installing Terraform on a Windows Server using Powershell](./lab07_Install_Terraform_on_Windows_Server/README.md).


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

## Resources

- [Terraform 1.0 - Provisioning AWS Infrastructure](https://cloudacademy.com/course/terraform-provisioning-aws-infrastructure/course-introduction/?context_resource=lp&context_id=2377)
- [Hands-On Infrastructure Automation with Terraform on AWS](https://github.com/PacktPublishing/Hands-on-Infrastructure-Automation-with-Terraform-on-AWS)
- [Implementing Terraform with AWS](https://www.pluralsight.com/courses/implementing-terraform-aws)
- [Applying Graph Theory to Infrastructure as Code](https://www.youtube.com/watch?v=Ce3RNfRbdZ0)
- [AWS DynamoDB resource not found exception](https://stackoverflow.com/questions/40192304/aws-dynamodb-resource-not-found-exception)
- [Installing or updating the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)