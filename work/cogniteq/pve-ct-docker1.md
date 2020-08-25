V1.Create CT on PVE witch Docker

- Add in config CT

vim /etc/pve/local/lxc/1XX.conf 
```
arch: amd64
cores: 2
insert--->>>features: keyctl=1,nesting=1
hostname: icoordinator
memory: 2048
nameserver: 10.172.0.1
net0: name=eth0,bridge=vmbr0,firewall=1,hwaddr=E6:C8:CF:5C:38:B1,ip=dhcp,type=veth
ostype: ubuntu
rootfs: local-lvm:vm-108-disk-0,size=20G
swap: 512
unprivileged: 1
```

- RUN
```
apt update -y
apt-get install curl -y
wget -O - https://raw.githubusercontent.com/vitovts/proto/master/work/cogniteq/docker-lxc-init-1.sh | bash
```

- Configure SSH

vim /etc/ssh/sshd_config 
```
PasswordAuthentication yes
PermitTunnel no
```
service ssh restart


