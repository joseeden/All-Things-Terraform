#! /bin/bash
apt-get -y update
apt-get -y install nginx
apt-get -y install jq

# Creates the variables
# ALB_DNS defined where the frontend will forward the API requests to.
# MONGODB_PRIVATEIP defines where the data will be written to
ALB_DNS=${aws_lb.lab06-alb.dns_name}
MONGODB_PRIVATEIP=${var.mongodb_ip}

mkdir -p /tmp/cloudacademy-app
cd /tmp/cloudacademy-app

echo ===========================
echo FRONTEND - download latest release and install...
mkdir -p ./voteapp-frontend-react-2020
pushd ./voteapp-frontend-react-2020
curl -sL https://api.github.com/repos/cloudacademy/voteapp-frontend-react-2020/releases/latest | jq -r '.assets[0].browser_download_url' | xargs curl -OL
INSTALL_FILENAME=$(curl -sL https://api.github.com/repos/cloudacademy/voteapp-frontend-react-2020/releases/latest | jq -r '.assets[0].name')
tar -xvzf $INSTALL_FILENAME
rm -rf /var/www/html
cp -R build /var/www/html
cat > /var/www/html/env-config.js << EOFF
window._env_ = {REACT_APP_APIHOSTPORT: "$ALB_DNS"}
EOFF
popd

echo ===========================
echo API - download latest release, install, and start...
mkdir -p ./voteapp-api-go
pushd ./voteapp-api-go
curl -sL https://api.github.com/repos/cloudacademy/voteapp-api-go/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")) | .browser_download_url' | xargs curl -OL
INSTALL_FILENAME=$(curl -sL https://api.github.com/repos/cloudacademy/voteapp-api-go/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")) | .name')
tar -xvzf $INSTALL_FILENAME
#start the API up...
MONGO_CONN_STR=mongodb://$MONGODB_PRIVATEIP:27017/langdb ./api &
popd

systemctl restart nginx
systemctl status nginx
echo fin v1.00!