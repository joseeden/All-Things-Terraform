
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