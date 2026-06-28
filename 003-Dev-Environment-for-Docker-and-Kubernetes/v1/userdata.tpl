#cloud-config
system_info:
  default_user:
    name: eden

runcmd:
### Install packages required for the container runtime
- 'sudo apt-get update -y'
- 'sudo apt-get install -y curl apt-transport-https ca-certificates lsb-release gnupg-agent software-properties-common gnupg'
- 'sudo mkdir -p /etc/apt/keyrings'
###--------------------------------------------------------------------------------
### Allow forwarding IPv4 by loading br_netfilter module 
- 'sudo modprobe overlay'
- 'sudo modprobe br_netfilter'
- |
  cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf \
  overlay
  br_netfilter
  EOF
### Allow the Linux node's iptables to correctly view bridged traffic
- |
  cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
  net.bridge.bridge-nf-call-iptables  = 1
  net.ipv4.ip_forward                 = 1
  net.bridge.bridge-nf-call-ip6tables = 1
  EOF
- sudo sysctl --system
###--------------------------------------------------------------------------------
### Install docker 
# - 'sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg'
# - 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge test" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'
# - 'sudo apt-get update -y'
# - 'sudo apt-get install -y docker-ce docker-ce-cli containerd.io '
# - 'sudo usermod -aG docker ubuntu'
###--------------------------------------------------------------------------------
### Install containerd using the DEB package distributed by Docker
- 'sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg'
# Set up the repository
- 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'
# Install containerd
- 'sudo apt-get update'
- 'sudo apt-get install -y containerd.io=1.4.4-1'
### Mitigate the instability of having two cgroup managers
- 'sudo mkdir -p /etc/containerd'
- 'containerd config default | sudo tee /etc/containerd/config.toml'
- 'sudo sed -i 's/ \[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options\]/          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]\n            SystemdCgroup = true/' /etc/containerd/config.toml'
- 'sudo systemctl restart containerd'
### Install kubeadm, kubelet, kubectl
- 'sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add '
- 'sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"'
- 'sudo apt-get update -y'
- 'sudo apt-get install -y kubeadm=1.24.3-00 kubelet=1.24.3-00 kubectl=1.24.3-00'
- 'sudo apt-mark hold kubeadm kubelet kubectl'
###--------------------------------------------------------------------------------
### Install docker-compose
- 'sudo apt install -y docker-compose docker-compose-plugin'
### Installs NodeJS
- 'curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -'
- 'sudo apt install -y nodejs'
- 'sudo apt install -y build-essential'
### Install golang
- 'sudo apt-get update -y'
- 'sudo apt-get upgrade'
- 'sudo apt install -y golang-go'
### Installs 'tree'
- 'sudo apt install -y tree'

# Configure prompt, terminal
# - 'echo "alias lld=ll -d */" >> .bashrc'
# - 'echo "alias llf=ll -p | grep -v /" >> .bashrc'
# - 'echo "alias src=source ~/.bashrc" >> .bashrc'
# - 'echo "alias cl=clear" >> .bashrc'
