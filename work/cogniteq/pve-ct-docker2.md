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

```

vim /etc/ssh/sshd_config 
```
# $OpenBSD: sshd_config,v 1.101 2017/03/14 07:19:07 djm Exp $

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/usr/bin:/bin:/usr/sbin:/sbin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options override the
# default value.

#Port 22
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

#HostKey /etc/ssh/ssh_host_rsa_key
#HostKey /etc/ssh/ssh_host_ecdsa_key
#HostKey /etc/ssh/ssh_host_ed25519_key

# Ciphers and keying
#RekeyLimit default none

# Logging
#LogLevel INFO

# Authentication:

#LoginGraceTime 2m
PermitRootLogin yes
#StrictModes yes
#MaxAuthTries 6
#MaxSessions 10

#PubkeyAuthentication yes

# Expect .ssh/authorized_keys2 to be disregarded by default in future.
#AuthorizedKeysFile     .ssh/authorized_keys .ssh/authorized_keys2

#AuthorizedPrincipalsFile none

#AuthorizedKeysCommand none
#AuthorizedKeysCommandUser nobody

# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
#HostbasedAuthentication no
# Change to yes if you don't trust ~/.ssh/known_hosts for
# HostbasedAuthentication
#IgnoreUserKnownHosts no

#To disable tunneled clear text passwords, change to no here!
>>PasswordAuthentication yes
#PermitEmptyPasswords no

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no

# Kerberos options
#KerberosAuthentication no

# Kerberos options
#KerberosAuthentication no
#KerberosOrLocalPasswd yes
#KerberosTicketCleanup yes
#KerberosGetAFSToken no

# GSSAPI options
#GSSAPIAuthentication no
#GSSAPICleanupCredentials yes
#GSSAPIStrictAcceptorCheck yes
#GSSAPIKeyExchange no

# Set this to 'yes' to enable PAM authentication, account processing,
# and session processing. If this is enabled, PAM authentication will
# be allowed through the ChallengeResponseAuthentication and
# PasswordAuthentication.  Depending on your PAM configuration,
# PAM authentication via ChallengeResponseAuthentication may bypass
# the setting of "PermitRootLogin without-password".
# If you just want the PAM account and session checks to run without
# PAM authentication, then enable this but set PasswordAuthentication
# and ChallengeResponseAuthentication to 'no'.
UsePAM yes

#AllowAgentForwarding yes
#AllowTcpForwarding yes
#GatewayPorts no
X11Forwarding yes
#X11DisplayOffset 10
X11UseLocalhost yes
#PermitTTY yes
PrintMotd no
#PrintLastLog yes
#TCPKeepAlive yes
#UseLogin no
#PermitUserEnvironment no
#Compression delayed
#ClientAliveInterval 0
#ClientAliveCountMax 3
#UseDNS no
#PidFile /var/run/sshd.pid
#MaxStartups 10:30:100
>>PermitTunnel no
#ChrootDirectory none
#VersionAddendum none

# no default banner path
#Banner none

# Allow client to pass locale environment variables
AcceptEnv LANG LC_*

# override default of no subsystems
Subsystem       sftp    /usr/lib/openssh/sftp-server
# Example of overriding settings on a per-user basis
#Match User anoncvs
#       X11Forwarding no
#       AllowTcpForwarding no
#       PermitTTY no
#       ForceCommand cvs server
```

service ssh restart


```
Псевдографика
    udo apt-get install dialog


Опробовать его можно простой командой:

    dialog --title " Уведомление " --msgbox "\n Свершилось что-то страшное!" 6 50

```



curl
```
Restarting services possibly affected by the upgrade:
Services restarted successfully.
