#LAMP

#GCP

1.VM Instances

2.Install Apache and PHP

- Debian 8 and Ubuntu 14
```bash
sudo apt-get update
sudo apt-get install apache2 php5 libapache2-mod-php5
```
- Debian 9 and Ubuntu 16/17
```bash
sudo apt-get update
sudo apt-get install apache2 php libapache2-mod-php
```
- CentOS 6 and 7
```bash
& Install Apache and PHP:
sudo yum check-update
sudo yum -y install httpd php
& Start the Apache service:
sudo service httpd start
& Optional: Set the Apache service to start automatically:
sudo chkconfig httpd on 
```

3. Test Apache and PHP

   - http://[$IP_EXTERNAL]
   
   - sudo sh -c 'echo "[$PHP_CODE]" > /var/www/html/phpinfo.php' ([$PHP_CODE] == <?php phpinfo();?>)
   ```bash
   sudo sh -c 'echo "<?php phpinfo();?>" > /var/www/html/phpinfo.php'
   ```
   - http://[$IP_EXTERNAL]/phpinfo.php


4. Install MySQL

 - Debian/Ubuntu
 ```bash
 sudo apt-get install mysql-server php-mysql php-pear
 ```

 - Ubuntu 16
 ```bash
 sudo apt-get install mysql-server php7.0-mysql php-pear
 ```
 
 - CentOS 6
 ```bash
 & Install MySQL and components
 sudo yum -y install httpd mysql-server php php-mysql
 & Start the MySQL service
 sudo service mysqld start
 & Optional: Set the MySQL service to start automatically
 sudo chkconfig mysqld on
 ```

 - CentOS 7
 ```bash
 & Install MariaDB and components
 sudo yum -y install httpd mariadb-server php php-mysql
 & Start the MariaDB service
 sudo systemctl start mariadb
 & Optional: Set the MariaDB service to start automatically
 sudo systemctl enable mariadb
 ```

5. Configure MySQ
 ```bash
 sudo mysql_secure_installation
 ```

6. Install phpMyAdmin

 - Debian/Ubuntu
 ```bash
 sudo apt-get install phpmyadmin
 ```

 - CentOS 6 and 7
 ```bash
 sudo yum install phpMyAdmin
 ```

7. Configure phpMyAdmin

 - Debian/Ubuntu

   - Select apache2.
   - Select yes to use dbconfig-common for database setup.
   - Enter the database administrator's password that you chose during MySQL configuration.
   - Enter a password for the phpMyAdmin application.
   - #1698 - Access denied for user 'root'@'localhost'
     ```bash
     sudo mysql -u root -p
     MariaDB [(none)]>
      use mysql;
      update user set plugin='' where User='root';
      flush privileges;
      exit;
     ```
     ```bash
     sudo mysql -u root -P 
     & create user for phpMyAdmin
     MariaDB [(none)]>
      CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASSWD';
      GRANT ALL PRIVILEGES ON *.* TO '$USER'@'localhost' WITH GRANT OPTION;
      FLUSH PRIVILEGES;
      quit;
     ```
     ```bash
     sudo vim /etc/dbconfig-common/phpmyadmin.conf
     ```
     
 - CentOS 6 and 7

   - By default, phpMyAdmin allows connections from only localhost. To access the database from a workstation, modify the Allow directive in the Apache configuration file for phpMyAdmin.
   ```bash
   sudo vim /etc/httpd/conf.d/phpMyAdmin.conf
   ...
   <IfModule !mod_authz_core.c>
     # Apache 2.2
     Order Deny,Allow
     Deny from All
     Allow from [YOUR_WORKSTATION_IP_ADDRESS]
     Allow from 127.0.0.1
     Allow from ::1
   </IfModule>
   ```
   - Restart the Apache service:

 - CentOS 6
  ```bash
  sudo service httpd restart
  ```
  
 - CentOS 7
  ```bash
  sudo systemctl restart httpd
  ```

8. Test phpMyAdmin

    http://[$IP_EXTERNAL]/phpmyadmin

9. Secure phpMyAdmin

10. DNS

11. Configure

 - Debian/Ubuntu: 
   - web server document root is at /var/www/html 
   - apache configuration file is at /etc/apache2/sites-available/default.

 - CentOS: 
   - web server document root is at /var/www/html 
   - apache configuration file is at /etc/httpd/conf/httpd.conf.


