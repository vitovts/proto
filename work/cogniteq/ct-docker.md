#bash

apt-get install docker
docker ps
    3  apt install docker.io
    4  docker ps
    5  apt install docker.io
    6  apt update
    7  apt install docker.io
    8  docker ps
    9  docker run hello-world
   10  apt-get remove docker docker-engine docker.io containerd runc
 
 
 
 apt-get install     apt-transport-https     ca-certificates     curl     gnupg-agent     software-properties-common
 
 
 12  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   13  apt-key fingerprint 0EBFCD88
   14  add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   15     $(lsb_release -cs) \
   16     stable"
   17  apt-get update
   18  apt-get install docker-ce docker-ce-cli containerd.io
   19  docker run hello-world
   20  docker ps
   21  docker run hello-world
   22  nano /etc/ssh/sshd_config 
   23  service ssh restart
   24  history
   
