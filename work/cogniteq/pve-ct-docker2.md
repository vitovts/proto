V2.Create CT on PVE witch Docker

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

```
apt update -y 
apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y 
>>>YES<<<
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  
apt-key fingerprint 0EBFCD88  
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"  
apt-get update -y 
apt-get install docker-ce docker-ce-cli containerd.io -y 
docker run hello-world 
docker ps
apt install net-tools -y

vim /etc/ssh/sshd_config 
service ssh restart
```



