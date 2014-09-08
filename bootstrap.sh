#!/usr/bin/env bash

sudo apt-get update


sudo apt-get install -y vim tmux curl wget build-essential python-software-properties

sudo add-apt-repository ppa:ondrej/php5
sudo apt-get update
sudo apt-get install -y php5
sudo apt-get update


sudo apt-get install -y git-core apache2 libapache2-mod-php5 php5-mysql php5-curl php5-gd php5-mcrypt php5-xdebug

sudo apt-get update

#Apache stuff
sudo a2enmod rewrite

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server 2> /dev/null
sudo apt-get install -y mysql-client 2> /dev/null

if [ ! -f /var/log/dbinstalled ];
then
    echo "CREATE USER 'mysqluser'@'localhost' IDENTIFIED BY 'USERPASSWORD'" | mysql -uroot -proot
    echo "CREATE DATABASE internal" | mysql -uroot -proot
    echo "GRANT ALL ON internal.* TO 'mysqluser'@'localhost'" | mysql -uroot -proot
    echo "flush privileges" | mysql -uroot -proot
    touch /var/log/dbinstalled
    if [ -f /vagrant/data/initial.sql ];
    then
        mysql -uroot -proot internal < /vagrant/data/initial.sql
    fi
fi

echo "*************************************************************"
echo "APACHE USR GROUP SETUP"
echo "*************************************************************"

    rm -rf /var/www
    ln -fs /vagrant /var/www
    
#APACHEUSR=`grep -c 'APACHE_RUN_USER=www-data' /etc/apache2/envvars`
#APACHEGRP=`grep -c 'APACHE_RUN_GROUP=www-data' /etc/apache2/envvars`
#if [ APACHEUSR ]; then
sudo sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=vagrant/g' /etc/apache2/envvars
#fi
#if [ APACHEGRP ]; then
sudo sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=vagrant/g' /etc/apache2/envvars
#fi

sudo sed -i 's_/var/www/html_/var/www/public_g' /etc/apache2/sites-available/000-default.conf

#comment out these two line numbers
#sudo sed -i'' '165,165 s/^/#/' /etc/apache2/apache2.conf 
#sudo sed -i'' '167,167 s/^/#/' /etc/apache2/apache2.conf 

sudo sed -i 's_AllowOverride None_AllowOverride All_g' /etc/apache2/apache2.conf


sudo chown -R vagrant:www-data /var/lock/apache2
	
# if /var/www is not a symlink then create the symlink and set up apache
#if [ ! -h /var/www ];
#then
#    rm -rf /var/www
#    ln -fs /vagrant /var/www
#    sudo a2enmod rewrite 2> /dev/null
#    sed -i '/AllowOverride None/c AllowOverride All' /etc/apache2/sites-available/default
    #sudo service apache2 restart 2> /dev/null
#fi


sudo service apache2 restart