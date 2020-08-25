#!/usr/bin/env bash

apt purge postfix -y && \
apt purge postfix-sqlite -y && \
apt purge xxd -y && \
apt purge cpp -y && \
apt purge cpp-6 -y && \
apt purge fontconfig-config -y && \
apt purge fonts-dejavu-core -y && \
apt purge gnupg gnupg-agent -y && \
apt purge pinentry-curses -y && \
apt purge x11-apps -y && \ 
apt purge x11-common -y && \
apt purge x11-session-utils -y && \
apt purge x11-utils -y && \
apt purge x11-xkb-utils -y && \
apt purge x11-xserver-utils -y && \
apt purge xauth -y && \
apt purge xbase-clients -y && \
apt purge bind9-host -y && \
apt purge bzip2 -y && \
apt purge dbus -y && \
apt purge debian-faq -y && \
apt purge doc-debian -y && \
apt purge gettext-base -y && \
apt purge krb5-locales -y && \
apt purge locales lsof -y && \
apt purge manpages -y && \
apt purge mime-support -y && \
apt purge ncurses-term -y && \
apt purge reportbug -y && \
apt purge telnet -y && \
apt purge ucf -y && \
apt purge wamerican -y && \
apt purge libc-l10n -y && \              
apt purge libclass-isa-perl -y && \      
apt purge libevent-2.0-5 -y && \         
apt purge libgc1c2 -y && \               
apt purge libgpm2 -y && \                
apt purge libgssapi-krb5-2 -y && \       
apt purge libgssglue1 -y && \            
apt purge libk5crypto3 -y && \           
apt purge libldap-common -y && \         
apt purge liblockfile-bin -y && \        
apt purge libmagic-mgc -y && \           
apt purge libpci3 -y && \                
apt purge libsasl2-modules-db -y && \    
apt purge libsqlite3-0 -y && \           
apt purge libtasn1-6 -y && \             
apt purge libtokyocabinet9 -y && \      
apt purge libwgdb0 -y && \               
apt purge libwrap0 -y && \               
apt purge netcat-traditional -y && \     
apt purge perl-modules-5.24 -y && \      
apt purge traceroute -y && \             
apt purge xz-utils -y && \               
apt purge ca-certificates -y && \           
apt purge libassuan0 -y && \                
apt purge libbsd0 -y && \                   
apt purge libcurl3-gnutls -y && \           
apt purge libdbus-1-3 -y && \               
apt purge libdns-export162 -y && \          
apt purge libdrm2 -y && \                   
apt purge libelf1 -y && \                   
apt purge libexpat1 -y && \                 
apt purge libfastjson4 -y && \              
apt purge libffi6 -y && \                   
apt purge libfontenc1 -y && \               
apt purge libfreetype6 -y && \              
apt purge libgeoip1 -y && \                 
apt purge libglapi-mesa -y && \             
apt purge libgmp10 -y && \                  
apt purge libicu57 -y && \                  
apt purge libip6tc0 -y && \                 
apt purge libisc-export160 -y && \          
apt purge libksba8 -y && \                  
apt purge liblocale-gettext-perl -y && \    
apt purge libmpdec2 -y && \                 
apt purge libnettle6 -y && \                
apt purge libnfnetlink0 -y && \             
apt purge libnghttp2-14 -y && \             
apt purge libnpth0 -y && \                 
apt purge libperl5.24 -y && \               
apt purge libpng16-16 -y && \               
apt purge libpsl5 -y && \                   
apt purge libpython2.7-minimal -y && \      
apt purge libpython3.5-minimal -y && \      
apt purge libssh2-1 -y && \                 
apt purge libtext-charwidth-perl -y && \    
apt purge libtext-iconv-perl -y && \        
apt purge libverto-libev1 -y && \           
apt purge libx11-data -y && \               
apt purge libx11-xcb1 -y && \               
apt purge libxau6 -y && \                   
apt purge libxshmfence1 -y && \             
apt purge libxtables12 -y && \              
apt-get autoremove -y && \
apt-get autoclean -y && \
apt install resolvconf -y && \
apt update && \
apt install \
     apt-transport-https \
     ca-certificates \
     gnupg-agent \
     gnupg2 \
     software-properties-common -y && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - && \
apt-key fingerprint 0EBFCD88 && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt update && \
apt upgrade -y && \
apt install docker-ce -y && \
mkdir /etc/systemd/system/docker.service.d && \
curl -L http://bit.ly/2EBxrWT >> /etc/systemd/system/docker.service.d/docker.conf && \
curl -L http://bit.ly/2C4X9RL >> /etc/docker/daemon.json && \
systemctl daemon-reload && \
service docker restart
