yum update -y
yum upgrde -y
yum install mc vim -y
vim /etc/selinux/config 
reboot
yum install epel-release -y
yum update -y
rpm -qa openvpn

firewall-cmd --list-all
firewall-cmd --permanent --remove-service=dhcpv6-client
firewall-cmd --permanent --add-service=samba
firewall-cmd --permanent --add-service=openvpn
firewall-cmd --permanent --add-interface=tap29
firewall-cmd --reload
firewall-cmd --list-all

systemctl start openvpn-client@tap29
systemctl enable openvpn-client@tap29
   
   
vim /etc/default/grub 
grub2-mkconfig -o /boot/grub2/grub.cfg 

yum remove NetworkManager 
reboot

systemctl start openvpn-client@tap29

vim /etc/resolv.conf 

yum install chrony
vim /etc/chrony.conf
systemctl start chronyd && systemctl enable chronyd
systemctl status chronyd 

yum install realmd sssd sssd-libwbclient oddjob oddjob-mkhomedir adcli samba-common samba-common-tools
vim /etc/hosts
vim /etc/resolv.conf 
realm discover cktema.lan
realm join -U iqsupport CKTEMA.LAN
id iqsupport@cktema.lan
realm list
adcli info cktema.lan

yum install samba
vim /etc/samba/smb.conf
systemctl start smb.service
testparm
mkdir /mnt/shara
chmod 777 -R /mnt/shara

realm list
firewall-cmd --list-all

systemctl start smb.service
systemctl status smb.service

yum install samba-winbind samba-winbind-clients samba pam_krb5 krb5-workstation chrony
authconfig --enablekrb5 --krb5kdc=cktema.lan --krb5adminserver=cktema.lan.local --krb5realm=CKTEMA.LAN --enablewinbind --enablewinbindauth --smbsecurity=ads --smbrealm=CKTEMA.LAN --smbservers=cktema.lan --smbworkgroup=CKTEMA --winbindtemplatehomedir=/home/%U --winbindtemplateshell=/bin/bash --enablemkhomedir --enablewinbindusedefaultdomain --update

net ads join -U iqsupport

systemctl start smb.service
tail -f /var/log/samba/log.smbd 

vim /etc/krb5.conf
systemctl enable smb.service
systemctl start winbind
systemctl start smb.service
systemctl enable winbind
systemctl enable smb.service

wbinfo -t
wbinfo -u
wbinfo -g

wbinfo -a CKTEMA\\iqsupport
id iqsupport
chown iqsupport:'Domain Users' /mnt/shara
ll /mnt/

fdisk -l
fdisk /dev/sdb
fdisk -l
mkfs.ext4 /dev/sdb1
fdisk -l
mkdir -p /mnt/cktema
ls -la /mnt/

vim /etc/fstab 
mount

rm -r /mnt/sktema/
vim /etc/fstab 
reboot

adcli info cktema.lan
chown iqsupport:'Domain Users' /mnt/cktema
chmod 0750 /mnt/cktema/

getfacl /mnt/cktema/
chmod 777 -R /mnt/cktema/
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