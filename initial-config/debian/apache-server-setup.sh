#!/bin/bash

echo "* Install prerequisites ..."
apt update && apt install -y nano curl tree

echo "* Install Apache ..."
apt update && apt install -y apache2

echo "* Install PHP ..."
apt update && apt install -y php

# echo "* Turn off the default web page ..."
# sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf

# echo "* Change config file and test..."
# sed -i "89s/localhost/`hostname`/" /etc/httpd/conf/httpd.conf
# sed -i "98s/#//" /etc/httpd/conf/httpd.conf
# sed -i "98s/www.example.com/`hostname`/" /etc/httpd/conf/httpd.conf
# sed -i '147s/Indexes //' /etc/httpd/conf/httpd.conf
# sed -i '167s/index.html/index.php index.html/' /etc/httpd/conf/httpd.conf
# apachectl configtest

echo "* Start and enable the service ..."
systemctl enable --now apache2
systemctl status apache2

echo "* Create custom index file ..."
echo "Custom index.html Web Page" | tee /var/www/html/index.html

echo "* Test ..."
curl localhost