#!/bin/bash

echo "* Copy the files to the appropriate folders ..."
cp /vagrant/vagrant/reverse-proxy/proxy-setup.conf /etc/httpd/conf.d/reverse-proxy.conf
apachectl configtest

echo "* Restart the service ..."
systemctl restart httpd && systemctl status httpd

echo "* Adjust SELinux boolean ..."
setsebool -P httpd_can_network_connect on