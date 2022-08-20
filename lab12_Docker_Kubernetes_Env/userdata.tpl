#cloud-config
system_info:
  default_user:
    name: eden

runcmd:
# Install docker
- 'sudo apt-get update -y'
- 'sudo apt-get install -y curl apt-transport-https ca-certificates lsb-release gnupg-agent software-properties-common'
- 'sudo mkdir -p /etc/apt/keyrings'
- 'sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg'
- 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge test" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'
- 'sudo apt-get update -y'
- 'sudo apt-get install -y docker-ce docker-ce-cli containerd.io '
- 'sudo usermod -aG docker ubuntu'
# Install docker-compose
- 'sudo apt install -y docker-compose docker-compose-plugin'
# Install kubeadm, kubelet, kubectl
- 'sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add '
- 'sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"'
- 'sudo apt-get update -y'
- 'sudo apt-get install -y kubeadm kubelet kubectl'
- 'sudo apt-mark hold kubeadm kubelet kubectl'
# Installs NodeJS
- 'curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -'
- 'sudo apt install -y nodejs'
- 'sudo apt install -y build-essential'
# Install golang
- 'sudo apt-get update -y'
- 'sudo apt-get upgrade'
- 'sudo apt install -y golang-go'
# Installs 'tree'
- 'sudo apt install -y tree'

# Configure prompt, terminal
# - 'echo "alias lld=ll -d */" >> .bashrc'
# - 'echo "alias llf=ll -p | grep -v /" >> .bashrc'
# - 'echo "alias src=source ~/.bashrc" >> .bashrc'
# - 'echo "alias cl=clear" >> .bashrc'
