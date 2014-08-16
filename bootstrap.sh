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

rm -rf /var/www
ln -fs /vagrant /var/www

sudo service apache2 restart