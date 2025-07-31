apt update && apt install -y openssh-server sudo passwd nscd
mkdir -p /run/sshd

user=$1
passwd=$2
# 添加用户，设置密码（不复用 root UID）
useradd -m -s /bin/bash $user
echo '$user:$passwd' | chpasswd
usermod -aG sudo $user

# 修改 ssh 配置
sed -i 's/^#\?\(PermitRootLogin\|PasswordAuthentication\).*/\1 yes/' /etc/ssh/sshd_config
