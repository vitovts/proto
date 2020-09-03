#PRE
```
yum update -y
yum install epel-release mc vim -y

vim /etc/selinux/config 

firewall-cmd --list-all
firewall-cmd --permanent --remove-service=dhcpv6-client
firewall-cmd --permanent --add-service=samba
firewall-cmd --permanent --add-service=openvpn
firewall-cmd --permanent --add-interface=tap29
firewall-cmd --reload
firewall-cmd --list-all

yum update -y
reboot
```

#REMOVE IPv6 + NetworkManager 
```
vim /etc/default/grub 
cat-> ipv6.disable=1
GRUB_CMDLINE_LINUX="ipv6.disable=1 crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet"
grub2-mkconfig -o /boot/grub2/grub.cfg 

vim /etc/sysconfig/network-scripts/ifcfg-ens192
BOOTPROTO="static"

yum remove NetworkManager 

reboot
```

#DNS
```
vim /etc/resolv.conf 

domain XXX.LOCAL
search XXX.LOCAL
nameserver X.X.X.X
nameserver 8.8.8.8
```


#OpenVPN
```
rpm -qa openvpn
yum install openvpn -y

mkdir -p /var/log/openvpn/
systemctl start openvpn-client@tun0
systemctl enable openvpn-client@tun0
```


#TIME
```
yum install chrony -y

vim /etc/chrony.conf
-->> server x.x.x.x iburst

systemctl start chronyd && systemctl enable chronyd
systemctl status chronyd 
```

#INSTALL to ADDS
```
yum install realmd sssd sssd-libwbclient oddjob oddjob-mkhomedir adcli samba-common samba-common-tools

vim /etc/hosts
vim /etc/resolv.conf 

realm discover xxx.local
realm join -U iqxxx XXX.LOCAL
id iqxxx@xxx.localan

realm list

adcli info xxx.local
```

#SAMBA
```
yum install samba -y
```
vim /etc/samba/smb.conf
```
[global]
#charset
        dos charset = cp866
        unix charset = utf-8

        workgroup = XXX
        realm = XXX.LOCAL
        security = ads

        interfaces = lo tap29 172.16.0.0/16 10.0.0.0/8
        interfaces = lo tun0 10.0.0.0/8
        
#       idmap config * : rangesize = 1000000
        idmap config * : range = 1000000-19999999
#       idmap config * : backend = autorid

        template homedir = /home/%U
        template shell = /bin/bash
        kerberos method = secrets only
        winbind use default domain = true
        winbind offline logon = false

#       encrypt passwords = yes
        passdb backend = tdbsam

        load printers = no
        show add printer wizard = no

printcap name = /dev/null
        disable spoolss = yes

        domain master = no
        local master = no
        preferred master = no
        os level = 1

        cups options = raw
        #logs
        log file = /var/log/samba/log.%m
        log level =3
        max log size = 500
#       printing = cups


[CKTEMA]
        comment = Documents for CKTEMA
        path = /mnt/cktema
#       public = no
#       guest ok = no
#       valid users = @"Domain Users@cktema.lan", @"iqsupport@cktema.lan"
#        writeable = yes
#        browsable = yes
 valid users = "@CKTEMA.LAN\Domain Users", root, iqsupport
 read list = "@CKTEMA.LAN\Domain Users", root, iqsupport
 write list = "@CKTEMA.LAN\Domain Users", root, iqsupport
 read only = no
#        admin users = "@CKTEMA\Администраторы домена",@"iqsupport@cktema.lan"
        create mask = 0765
#        directory mask = 0700
```

```
systemctl start smb.service

testparm

mkdir /mnt/xxx

chmod 777 -R /mnt/xxx

realm list

firewall-cmd --list-all

systemctl start smb.service && systemctl enable smb.service
systemctl status smb.service
```

```
yum install samba-winbind samba-winbind-clients samba pam_krb5 krb5-workstation chrony
```
```
authconfig --enablekrb5 --krb5kdc=gkvtormet.local --krb5adminserver=gkvtormet.local --krb5realm=GKVTORMET.LOCAL --enablewinbind --enablewinbindauth --smbsecurity=ads --smbrealm=GKVTORMET.LOCAL --smbservers=gkvtormet.local --smbworkgroup=GKVTORMET --winbindtemplatehomedir=/home/%U --winbindtemplateshell=/bin/bash --enablemkhomedir --enablewinbindusedefaultdomain --update
```
```
authconfig --enablekrb5 --krb5kdc=cktema.lan --krb5adminserver=cktema.lan --krb5realm=CKTEMA.LAN --enablewinbind --enablewinbindauth --smbsecurity=ads --smbrealm=CKTEMA.LAN --smbservers=cktema.lan --smbworkgroup=CKTEMA --winbindtemplatehomedir=/home/%U --winbindtemplateshell=/bin/bash --enablemkhomedir --enablewinbindusedefaultdomain --update
```

```
net ads join -U iqsupport

systemctl restart smb.service

tail -f /var/log/samba/log.smbd 

vim /etc/krb5.conf

systemctl start winbind && systemctl enable winbind
systemctl start smb.service && systemctl enable smb.service

wbinfo -t

wbinfo -u

wbinfo -g

wbinfo -a XXX\\iqsupport

id iqsupport
```

```
chown iqsupport:'Domain Users' /mnt/shara
## пользователи домена
```


```
ll /mnt/

fdisk -l

fdisk /dev/sdb

fdisk -l

mkfs.ext4 /dev/sdb1

fdisk -l

mkdir -p /mnt/xxx

ls -la /mnt/

vim /etc/fstab 
-->> /dev/sdb1                       /mnt/xxx     ext4    defaults        0 0

reboot
```

adcli info cktema.lan

chown iqsupport:'Domain Users' /mnt/cktema

chmod 0750 /mnt/xxx/
chmod 777 -R /mnt/xxx/
getfacl /mnt/xxx/



chown iqsupport:'domain users' /mnt/cktema

getfacl /mnt/cktema/

setfacl -m g:cktema:rwx /mnt/cktema/

getfacl /mnt/cktema/

setfacl -m d:g:cktema:rwx,d:g:'domain users':rx /mnt/cktema

chcon -t samba_share_t /mnt/cktema/

chown cktema:'domain users' /mnt/cktema
chown iqsupport:'cktema' /mnt/cktema

getfacl /mnt/cktema/

setfacl /mnt/cktema/

setfacl --help

setfacl -m d:g:cktema:rwx,d:u:iqsupport:rwx,d:g:'domain users':rx /mnt/cktema

setfacl -m d:g:cktema:rwx,d:u:iqsupport:rwx,d:g:'Domain Users':rwx /mnt/cktema

setfacl -m d:g:cktema:rwx,d:u:iqsupport:rwx,d:g:'Domain User':rwx /mnt/cktema

setfacl -m d:g:cktema:rwx,d:u:iqsupport:rwx,d:g:'пользователи домена':rwx /mnt/cktema

getfacl -m d:g:cktema:rwx,d:u:iqsupport:rwx,d:g:'пользователи домена':rwx /mnt/cktema

setfacl -m d:g:cktema:rwx,d:g:'пользователи домена':rx /mnt/shara


vim /etc/hostname 

vim /etc/krb5.conf

vim /etc/samba/smb.conf

vim /etc/hostname 

vim /etc/hosts


klist

wbinfo -g

realm join -U iqsupport CKTEMA.LAN

id iqsupport@cktema.lan

realm list

adcli info cktema.lan

net ads join -U iqsupport

wbinfo -t

wbinfo -u

wbinfo -g

klist 

kinit iqsupport 

pwd
```
