#bash

History
```
apt-get install docker
docker ps
apt install docker.io
docker ps
docker run hello-world

apt-get remove docker docker-engine docker.io containerd runc
 
apt-get install     apt-transport-https     ca-certificates     curl     gnupg-agent     software-properties-common
 
>>>YES<<<
 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
docker run hello-world
docker ps
docker run hello-world

vim /etc/ssh/sshd_config 
service ssh restart
```   


cat /etc/pve/local/lxc/108.conf 
```
arch: amd64
cores: 2
features: keyctl=1,nesting=1
hostname: icoordinator
memory: 2048
nameserver: 10.172.0.1
net0: name=eth0,bridge=vmbr0,firewall=1,hwaddr=E6:C8:CF:5C:38:B1,ip=dhcp,type=veth
ostype: ubuntu
rootfs: local-lvm:vm-108-disk-0,size=20G
swap: 512
unprivileged: 1
```







```
vim /var/lib/lxc/.../configure

lxc.arch = amd64
lxc.include = /usr/share/lxc/config/ubuntu.common.conf
lxc.include = /usr/share/lxc/config/ubuntu.userns.conf
lxc.apparmor.profile = generated
lxc.apparmor.allow_nesting = 1
lxc.monitor.unshare = 1
lxc.idmap = u 0 100000 65536
lxc.idmap = g 0 100000 65536
lxc.tty.max = 2
lxc.environment = TERM=linux
lxc.uts.name = icoordinator
lxc.cgroup.memory.limit_in_bytes = 2147483648
lxc.cgroup.memory.memsw.limit_in_bytes = 2684354560
lxc.cgroup.cpu.shares = 1024
lxc.rootfs.path = /var/lib/lxc/108/rootfs
lxc.net.0.type = veth
lxc.net.0.veth.pair = veth108i0
lxc.net.0.hwaddr = E6:C8:CF:5C:38:B1
lxc.net.0.name = eth0
lxc.cgroup.cpuset.cpus = 0,14
```




cat <<EOT >> /etc/pve/lxc/100.conf
#insert docker part below
lxc.apparmor.profile: unconfined
lxc.cgroup.devices.allow: a
lxc.cap.drop:
EOT
