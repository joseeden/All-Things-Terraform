# Configure the Credentials File

After you've installed the extension, you will need to configure the credentials profile. This will allow you to connect to your AWS account.

```bash
View --> Command Palette --> AWS: Create Credentials Profile
```

Populate the credentials file with the AWS Access key and secret access key from the CSV file you just downloaded earlier.  

![](Images/tfcredentials.png)  


The credentials file should be created with the text below. 

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
aws_access_key_id = AKIA1234ABCDEFGHIJK
# Treat your secret key like a password. Never share your secret key with anyone. Do 
# not post it in online forums, or store it in a source control system. If your secret 
# key is ever disclosed, immediately use IAM to delete the access key and secret key
# and create a new key pair. Then, update this file with the replacement key details.
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

If it doesn't exist, you can simply create a **credentials** file and put in the profile, access key and secret access key. For this one, I named the profile **vscode-dev** but you can call it whatever you like.

```bash
[vscode-dev]
aws_access_key_id = AKIA1234ABCDEFGHIJK
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Back in the Explorer tab, click **Connect to AWS** and select the credentials profile you created. It will prompt you use US-East-1 as default region. Select Yes for now.

To add another region, click the three dots at the Explorer tab and select **Show or hide regions**. We'll use Singapore region for this lab.

![](Images/tfshowhideregions.png)  
![](Images/tfshowregionssingapore.png) 