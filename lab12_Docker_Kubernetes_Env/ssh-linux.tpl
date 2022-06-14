cat << EOF >> /mnt/c/Users/Eden.Jose/.ssh/config

Host ${hostname}
  HostName ${hostname}
  User ${user}
  IdentityFile ${identityfile}
EOF