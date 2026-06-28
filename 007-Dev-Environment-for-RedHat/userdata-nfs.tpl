#cloud-config
system_info:
  default_user:
    name: eden

runcmd:
- 'sudo hostnamectl set-hostname tstrhel-nfs'
- 'sudo sed -i "s/localhost/localhost tstrhel-nfs/" /etc/hosts'
# - 'sudo echo "PS1=\"[\u@\H: \W] $ \"" >> .bashrc'
# Install dev tools
- 'sudo dnf update -y'
- 'sudo dnf install -y yum-utils'
- 'sudo dnf install -y firewalld'
- 'sudo dnf install -y python3 python3-pip'
- 'sudo dnf install -y vim-enhanced nano wget curl tree'
# - 'sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo'
# - 'sudo dnf install -y docker-ce --nobest'
# - 'sudo usermod -aG docker ${USER}'
# - 'sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose'
# - 'sudo chmod +x /usr/local/bin/docker-compose'
# # Snaps are applications packaged with all their dependencies to run on all popular Linux distributions from a single build. They update automatically and roll back gracefully.
# - 'sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y'
# - 'sudo dnf upgrade'
# - 'sudo dnf install -y snapd'
# # - 'sudo ln -s /var/lib/snapd/snap /snap'
# # Installs NodeJS v12 and below
# #- '# sudo dnf groupinstall "Development Tools" -y'
# # - '# sudo dnf module install nodejs -y'
# # - '# sudo dnf module install nodejs/development -y'
# # Install NodeJS v16
# - 'sudo curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo bash -'
# - 'sudo dnf install -y nodejs'
# # Install dev tools to build native addons to NodeJS
# - 'sudo dnf install -y gcc-c++ make'
# # Configure prompt, terminal
# - 'echo "alias lld=ll -d */" >> .bashrc'
# - 'echo "alias llf=ll -p | grep -v /" >> .bashrc'
# - 'echo "alias src=source ~/.bashrc" >> .bashrc'
# - 'echo "alias cl=clear" >> .bashrc'

