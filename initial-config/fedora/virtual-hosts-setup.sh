#!/bin/bash

echo "* Prepare the config files ..."
cp /vagrant/vagrant/virtual-hosts/main.conf /etc/httpd/conf.d/main.conf
cp /vagrant/vagrant/virtual-hosts/vhost-port.conf /etc/httpd/conf.d/vhost-port.conf
cp /vagrant/vagrant/virtual-hosts/vhost-name.conf /etc/httpd/conf.d/vhost-name.conf

echo "* Create needed folders ..."
mkdir /var/www/vhost-{name,port}

echo "* Create two new indexes files ..."
echo '<h1>Cutom index.html page for vhost by port</h1>' | tee /var/www/vhost-port/index.html
echo '<h1>Cutom index.html page for vhost by name</h1>' | tee /var/www/vhost-name/index.html

echo "* Test config ..."
apachectl configtest

echo "* Restart the service ..."
systemctl restart httpd

echo "* Adjust the firewall settings ..."
firewall-cmd --add-port 8080/tcp --permanent
firewall-cmd --reload

echo "* Create custom index file ..."
echo '192.168.100.161     www.demo.lab      www' | tee -a /etc/hosts

echo "* Change the ownership and permissions of the directory ..."
curl localhost
curl localhost:8080
curl www.demo.lab