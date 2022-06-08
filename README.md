
# Terraform Projects

This repository contains all the Terraform projects that I've worked on and I'm currently working on. The goal is "terraforming" different deployments that includes:

- Provisioning AWS resources
- Provisioning Azure resources
- Provisioning GCP resources
- Amazon EKS clusters
- Confluent Cloud resources
- Terraform tied up with Ansible and Jenkins

Before we began, make sure to read go through some of the prre-requisites that you need to install on your local machine.

## Pre-requisites

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


### Setup your Environment and Install Extensions 

For this one, I'm using VS Code. We'll set it up with the following extensions:

- AWS Toolkit Extension
- Terraform Extension

####  AWS Toolkit Extension

Click the View tab and then Extensions. In the search bar, type in the extension name.

![](Images/tfextension-aws.png)  

Once installed, you should see the the AWS icon on the left panel and **Connect to AWS** in the Explorer tab. Next, edit the credentials profile.

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


####  Terraform Extension

In the Extensions panel of VSCode, search for the Terraform extension. There's an official extension from Hashicorp but it is still buggy during the creation of this notes thus I suggest to install the extension from Anton Kulikov.

![](Images/tfextension1.png)  

Finally, create your working directory. For this lab, I called my working directory "lab01_build_dev_env".


### Install Terraform

To install Terraform, we can use the official documentation from Hashicorp which can be accessed through the first link below. Similarly, you can also follow the second link to install Terraform through WSL.

- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

- [Configuring Terraform on Windows 10 Linux Sub-System](https://techcommunity.microsoft.com/t5/azure-developer-community-blog/configuring-terraform-on-windows-10-linux-sub-system/ba-p/393845)

For the second link, here's a summary of commands. 

```bash
sudo apt-get update 
sudo apt-get upgrade 
sudo apt-get install unzip 
```
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

You need to get the most recent download URL from the Terraform [download page](https://www.terraform.io/downloads) first before unzipping the file. If you're running WSL on a Windows machine, right-click on any of the available packages for Linux.

After installing, verify.
```bash
$ terraform -v 
```