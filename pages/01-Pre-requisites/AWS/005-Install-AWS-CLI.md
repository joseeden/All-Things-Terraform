# Install AWS CLI

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