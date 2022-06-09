#!/bin/bash

# Get latest version
LATEST_TAG=$(curl -sL https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name)
VERSION=$(echo $LATEST_TAG | grep -Eo "(\d+\.)+\d+")

# Download latest version of the package
curl -OL https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip

# Install by unzipping the file.
unzip terraform_${VERSION}_linux_amd64.zip
mv terraform /usr/local/bin/

# Auto-completion setup
terraform -install-autocomplete

# Test
terraform -v