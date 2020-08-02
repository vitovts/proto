#SSH

#INSTALL
```bash
apt install -y openssh-server
systemctl status ssh
```

debian -->> sudo systemctl restart sshd



#ADD USER (SUDO)
```bash
$ adduser username
...
$ adduser username sudo
...
```

#CONFIGURE SSHD
```bash
$ vim /etc/ssh/sshd_config
  PermitRootLogin no
$ .... restart sshd
```

#GENERATION KEY
```bash
$ sudo ssh-keygen (root)
$ ssh-keygen (username)
$ ssh-keygen -b 4096 (4096-bit RSA, default 2048)
```

```output
Generating public/private rsa key pair.
Enter file in which to save the key (/home/username/.ssh/id_rsa):

Enter passphrase (empty for no passphrase):
```

#COPY KEY REMOTE (id_rsa.pub --->>> authorized_keys remote host)
```bash
$ su - username
$ mkdir -p ~/.ssh or /home/username/.ssh and touch /home/username/.ssh/authorized_keys

$ ssh-copy-id username@remote_host
```
OR
```bash
$ cat ~/.ssh/id_rsa.pub | pbcopy
$ vim ~/.ssh/authorized_keys - >> copy
$ chmod -R go= ~/.ssh
$ 
```

```bash
$ sudo vim /etc/ssh/sshd_config
  PasswordAuthentication no
$ restart sshd
```
```bash
$ sudo visudo 
 %sudo ALL=(ALL:ALL) NOPASSWD:ALL
```
-----------------

```bash
sudo apt install ufw
sudo apt-add-repository -y ppa:hda-me/nginx-stable
sudo apt-get install brotli nginx nginx-module-brotli
sudo systemctl unmask nginx.service --->>> Ubuntu 18
```


 load_module modules/ngx_http_brotli_filter_module.so;
 load_module modules/ngx_http_brotli_static_module.so;

