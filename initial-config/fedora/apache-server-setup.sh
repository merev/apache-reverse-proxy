#!/bin/bash

echo "* Install prerequisites ..."
dnf install -y nano curl tree

echo "* Install Apache ..."
dnf install -y httpd

echo "* Install Apache ..."
dnf module install -y php

echo "* Turn off the default web page ..."
sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf

echo "* Change config file and test..."
sed -i "89s/localhost/`hostname`/" /etc/httpd/conf/httpd.conf
sed -i "98s/#//" /etc/httpd/conf/httpd.conf
sed -i "98s/www.example.com/`hostname`/" /etc/httpd/conf/httpd.conf
sed -i '147s/Indexes //' /etc/httpd/conf/httpd.conf
sed -i '167s/index.html/index.php index.html/' /etc/httpd/conf/httpd.conf
apachectl configtest

echo "* Start and enable the service ..."
systemctl enable --now httpd
systemctl status httpd

echo "* Adjust the firewall settings ..."
firewall-cmd --add-service http --permanent
firewall-cmd --reload

echo "* Create custom index file ..."
echo "Custom index.html Web Page" | tee /var/www/html/index.html

echo "* Change the ownership and permissions of the directory ..."
curl localhost