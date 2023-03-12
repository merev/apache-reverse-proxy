#!/bin/bash

echo "* Create custom index file ..."
echo "Custom index.html Web Page Reverse Proxy" | tee /var/www/html/index.html

echo "* Enable the proxy module ..."
a2enmod proxy
a2enmod proxy_http

echo "* Copy the files to the appropriate folders ..."
cp /vagrant/vagrant/reverse-proxy/deb-proxy-setup.conf /etc/apache2/conf-available/reverse-proxy.conf

echo "* Enable the config and test ..."
a2enconf reverse-proxy
apachectl configtest

echo "* Restart the service ..."
systemctl restart apache2 && systemctl status apache2