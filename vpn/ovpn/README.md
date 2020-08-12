Install and Configure OpenVPN to CentOS

OS
```bash
cat /etc/redhat-release
```
```text
CentOS Linux release 7.8.2003 (Core)
```
Update
```bash
yum update -y
yum upgrade -y
yum install mc vim -y
```

Time zone
```bash
cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime
```

Install service synctime
```bash
yum install chrony
systemctl enable chronyd
systemctl start chronyd
```

#Disable Selinux:
```bash
setenforce 0
vim /etc/selinux/config
SELINUX=enforcing на: SELINUX=disabled
```

Firewalld
```bash
firewall-cmd --list-all
firewall-cmd --permanent --remove-service dhcpv6-client
firewall-cmd --permanent --add-service openvpn
firewall-cmd --permanent --add-port 13001/udp
firewall-cmd --list-all

firewall-cmd --permanent --zone=trusted --add-interface=tun0

MASQUERADE on the default zone
firewall-cmd --permanent --add-masquerade
firewall-cmd --reload
```

Install OpenVPN
```bash
yum install epel-release -y # epel
yum install openvpn easy-rsa -y
rpm -qa openvpn easy-rsa
->easy-rsa-3.0.7-1.el7.noarch
->openvpn-2.4.9-1.el7.x86_64
```


Create cert
```bash
cd /usr/share/easy-rsa/3
-> create
vim vars  
set_var EASYRSA                 "$PWD"
set_var EASYRSA_PKI             "$EASYRSA/pki"
set_var EASYRSA_DN              "cn_only"
set_var EASYRSA_REQ_COUNTRY     "RU"
set_var EASYRSA_REQ_PROVINCE    "MSK"
set_var EASYRSA_REQ_CITY        "MSK"
set_var EASYRSA_REQ_ORG         "WSIQ-Company"
set_var EASYRSA_REQ_EMAIL       "admin@server.vpn.ru"
set_var EASYRSA_REQ_OU          "WSIQ department"
set_var EASYRSA_KEY_SIZE        4096
set_var EASYRSA_ALGO            rsa
set_var EASYRSA_CA_EXPIRE       7500
set_var EASYRSA_CERT_EXPIRE     3650
set_var EASYRSA_NS_SUPPORT      "no"
set_var EASYRSA_NS_COMMENT      "WSIQ CERTIFICATE AUTHORITY"
set_var EASYRSA_EXT_DIR         "$EASYRSA/x509-types"
#set_var EASYRSA_SSL_CONF        "$EASYRSA/openssl-1.0.cnf"
set_var EASYRSA_DIGEST          "sha512"

chmod +x vars
```

```bash
wget https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.7/EasyRSA-3.0.7.tgz
wget https://raw.githubusercontent.com/OpenVPN/easy-rsa-old/master/easy-rsa/2.0/openssl-1.0.0.cnf
```

```bash
cd /usr/share/easy-rsa/3
./easyrsa init-pki
```
```output
Note: using Easy-RSA configuration from: /usr/share/easy-rsa/3.0.7/vars

init-pki complete; you may now create a CA or requests.
Your newly created PKI dir is: /usr/share/easy-rsa/3/pki
```

```bash
cd /usr/share/easy-rsa/3
./easyrsa build-ca
```output
Note: using Easy-RSA configuration from: /usr/share/easy-rsa/3.0.7/vars
Using SSL: openssl OpenSSL 1.0.2k-fips  26 Jan 2017

Enter New CA Key Passphrase: passwd
Re-Enter New CA Key Passphrase: passwd
Generating RSA private key, 4096 bit long modulus
.........................................................++ e is 65537 (0x10001)
You are about to be asked to enter information that will be incorporated into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value, If you enter '.', the field will be left blank.
-----
Common Name (eg: your user, host, or server name) [Easy-RSA CA]:WSIQ CA

CA creation complete and you may now import and sign cert requests.
Your new CA certificate file for publishing is at: /usr/share/easy-rsa/3/pki/ca.crt
```

Создаем ключ Диффи-Хеллмана:
```bash
cd /usr/share/easy-rsa/3
./easyrsa gen-dh
```
```output
Using SSL: openssl OpenSSL 1.0.2k-fips  26 Jan 2017 
Generating DH parameters, 4096 bit long safe prime, generator 2
This is going to take a long time
....................................



#Создаем запрос сертификата для сервера без пароля с помощью опции nopass, иначе придется вводить пароль с консоли при каждом запуске сервера
```bash
./easyrsa gen-req wsvpn3 nopass
```bash

#Подписываем запрос на получение сертификата у нашего CA:
```bash
./easyrsa sign-req server wsvpn3
```

#Варинт все сразу



#Для создания ta ключа используем команду:
```bash
openvpn --genkey --secret pki/ta.key
```
Сертификаты сервера готовы и находятся в каталоге pki. 

#Создаем каталог в /etc/openvpn, в котором будем хранить сертификаты:
```bash
mkdir /etc/openvpn/keys
```
Копируем в него содержимое каталога pki:
```bash
cp -r pki/* /etc/openvpn/keys/
```

Создаем каталог для логов сервера:
```bash
mkdir /var/log/openvpn
```

```bash
vim /etc/openvpn/server/server.conf

#local 41.85.203.227
port 13001
proto udp
dev tun

ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/issued/wsvpn3.crt
key /etc/openvpn/keys/private/wsvpn3.key
dh /etc/openvpn/keys/dh.pem
tls-auth /etc/openvpn/keys/ta.key 0

server 172.16.10.0 255.255.255.0

ifconfig-pool-persist ipp.txt
keepalive 10 120
#max-clients 32
#client-to-client

persist-key
persist-tun

status /var/log/openvpn/openvpn-status.log
log-append /var/log/openvpn/openvpn.log

verb 0
mute 20

daemon
mode server
tls-server
comp-lzo
```

#Start OpenVPN Service
```bash
systemctl start openvpn-server@server
systemctl enable openvpn-server@server
```
```bash
systemctl enable openvpn@server
systemctl start openvpn@server
```


Проверим слушается ли порт 1194 сервисом:
```bash
lsof -i:1194
netstat -tulnp | grep openvpn
```


Client config
```bash
client
resolv-retry infinite
nobind
remote 45.81.203.227 13001
proto udp
dev tun
comp-lzo
ca "C:\\Program Files\\OpenVPN\\wsvpn3\\ca.crt"
cert "C:\\Program Files\\OpenVPN\\wsvpn3\\client31.crt"
key "C:\\Program Files\\OpenVPN\\wsvpn3\\client31.key"
#dh "C:\\Program Files\\OpenVPN\\wsvpn3\\dh.pem"
tls-client
tls-auth "C:\\Program Files\\OpenVPN\\wsvpn3\\ta.key" 1
float
keepalive 10 120
persist-key
persist-tun
verb 0 
```













