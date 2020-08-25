  service apache2 start
  apt-get install apache2 
  apt update
  apt install nginx 
  service nginx start
  mysql -v
  pwd
  cd /var/www/
  cd html/
  uname -a
  mysql -v
  cat /etc/os-release 
  apt-get install software-properties-common
  apt-get update
  cd /etc/apt/sources.list.d/
  ls
  cat mariadb.10.4.list
  sudo cat mariadb.10.4.list
  sudo put  mariadb.10.4.list
  sudo t3ouch  mariadb.10.4.list
  sudo touch  mariadb.10.4.list
  ls
  sudo nano mariadb.10.4.list 
  sudo apt-get update
  apt-get update
  sudo nano mariadb.10.4.list 
  sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
  nano  /etc/os-release 
  sudo apt update
  sudo apt install mariadb-server
  sudo nano mariadb.10.4.list 
  sudo apt update
  mysql --version
  sudo apt-get install -y mariadb-client
  cd /etc/mysql
  sudo nano debian.cnf 
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get autoremove
  sudo mysql_secure_installation
  mysql -uroot
  sudo service nginx status
  sudo service nginx stop
  sudo apt-get install apache2
  sudo a2dissite 000-default.conf
  sudo service apache2 stop
  cd /etc/apache2/
  ls
  sudo nano ports.conf 
  sudo service apache2 start
  sudo service apache2 status
  sudo a2enmod rewrite
  sudo a2enmod expires
  sudo a2enmod headers
  sudo a2enmod proxy_fcgi
  sudo a2enmod proxy
  sudo a2enmod actions
  sudo a2enmod alias
  cd sites-available/
  ls
  systemctl restart apache2
  systemctl status apache2
  sudo service apache2 restart
  ls
  sudo apt-get install -y php7.2-fpm php7.2-mbstring php7.2-gd php7.2-curl php7.2-cgi php7.2-intl php7.2-xml php7.2-mysql php7.2-zip
  sudo apt-get install -y php-mysql
  sudo service php7.2-fpm start
  sudo systemctl enable php7.2-fpm
  sudo a2enconf php7.2-fpm
  systemctl reload apache2
  sudo service apache2 status
  cd /etc/nginx/
  ls
  cd sites-enabled/
  sudo nano default 
  rm -rf default 
  ls
  sudo service nginx restart
  cd ../sites-available/
  ls
  mv vagrant-site-default.conf ./ema.conf
  ls
  sudo ln -s /etc/nginx/sites-available/ema.conf /etc/nginx/sites-enabled/ema.conf
  sudo service nginx restart
  sudo service nginx status
  sudo service nginx restart
  sudo service nginx status
  sudo a2ensite ema.conf 
  systemctl reload apache2
  sudo service apache2 restart
  cd /var/www/ema/
  ls
  ls -la
  chown -R www-data:www-data *
  ls -la
  cd storage/
  ls
  ls -la
  mysql -uroot
  cd ../
  ls
  sudo nano .env
  110  php artisan db:migrate
  111  php artisan migrate:fresh
  112  sudo nano .env
  113  php artisan migrate:fresh
  114  cd routes/
  115  cd ..
  116  php artisan db:seed
  117  sudo service nginx restart
  118  sudo service apache2 restart
  119  sudo nano .env
  120  php artisan cache:clear
  121  sudo nano .env
  122  php artisan config:clear
  123  php artisan cache:clear
  124  cd /var/www/ema/
  125  ;s
  126  ls
  127  php artisan cache
  128  php artisan 
  129  php artisan migrate:fresh
  130  php artisan db:seed
  131  php artisan cache:clear
  132  chown -R www-data:www-data *
  133  cd /var/www/ema/
  134  php artisan cache:clear
  135  php artisan migrate:fresh
  136  php artisan db:seed
  137  cd /var/www/ema/
  138  php artisan migrate:fresh
  139  php artisan db:seed
  140  nano /etc/ssh/sshd_config
  141  service ssh restart
  142  ifconfig
  143  apt install net-tool
  144  ls
  145  apt install net-tools
  146  ifconfig
  147  service networking restart
  148  /etc/init.d/networking restart
  149  systemctl restart networking
  150  ifconfig eth0 down && ifconfig eth0 up
  151  ifconfig
  152  systemctl restart NetworkManager.service
  153  nano /etc/resolv.conf 
  154  ping mail.ru
  155  history
  156  ifconfig
  157  vim /etc/resolv.conf 
  158  vi /etc/resolv.conf 
  159  ping 8.8.8.8
