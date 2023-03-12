#!/bin/bash

################## Create self-signed certificate ##################

echo "* Install the necessary packages ..."
dnf install -y mod_ssl openssl

echo "* Generate the private key ..."
openssl genrsa -out ca.key 2048

echo "* Create a certificate signing request (CSR) ..."
openssl req -new -subj "/C=BG/ST=Plovidv/L=Plovidv/O=merev/OU=merev/CN=merev/emailAddress=dummy@mail.test" -key ca.key -out ca.csr

echo "* Generate the self-signed certificate ..."
openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt

echo "* Show the result ..."
openssl x509 -text -in ca.crt

echo "* Copy the files to the appropriate folders ..."
cp ca.crt /etc/pki/tls/certs/ca.crt
cp ca.key /etc/pki/tls/private/ca.key
cp ca.csr /etc/pki/tls/private/ca.csr

#######################################################################


################## Apache Settings ##################

echo "* Change SSL config file and test..."
sed -i "85s/localhost/ca/" /etc/httpd/conf.d/ssl.conf
sed -i "93s/localhost/ca/" /etc/httpd/conf.d/ssl.conf
apachectl configtest

echo "* Configure automatic redirect ..."
cp /vagrant/vagrant/ssl-config/ssl-redirect.conf /etc/httpd/conf.d/main.conf

echo "* Restart the service ..."
systemctl restart httpd && systemctl status httpd

echo "* Adjust the firewall settings ..."
firewall-cmd --add-service https --permanent
firewall-cmd --reload

#######################################################