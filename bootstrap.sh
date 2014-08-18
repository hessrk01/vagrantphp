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

sudo chown -R vagrant:www-data /var/lock/apache2

sudo service apache2 restart