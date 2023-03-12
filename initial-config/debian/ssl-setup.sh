#!/bin/bash

################## Create self-signed certificate ##################

echo "* Install the necessary packages ..."
apt update && apt install -y openssl

echo "* Generate the private key ..."
openssl genrsa -out ca.key 2048

echo "* Create a certificate signing request (CSR) ..."
openssl req -new -subj "/C=BG/ST=Plovidv/L=Plovidv/O=merev/OU=merev/CN=merev/emailAddress=dummy@mail.test" -key ca.key -out ca.csr

echo "* Generate the self-signed certificate ..."
openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt

echo "* Show the result ..."
openssl x509 -text -in ca.crt

echo "* Copy the files to the appropriate folders ..."
cp ca.crt /etc/ssl/certs/ca.crt
cp ca.key /etc/ssl/private/ca.key
cp ca.csr /etc/ssl/private/ca.csr

#######################################################################


################## Apache Settings ##################

# echo "* Change SSL config file and test..."
# sed -i "85s/localhost/ca/" /etc/httpd/conf.d/ssl.conf
# sed -i "93s/localhost/ca/" /etc/httpd/conf.d/ssl.conf
# apachectl configtest

echo "* Enable SSL modules ..."
a2enmod ssl
a2enmod rewrite

echo "* Activate SSL ..."
cp /vagrant/vagrant/ssl-config/deb-ssl-activate.conf /etc/apache2/sites-available/000-default-ssl.conf

echo "* Configure automatic redirect ..."
cp /vagrant/vagrant/ssl-config/deb-ssl-redirect.conf /etc/apache2/sites-available/000-default.conf

echo "* Enable the SSL version of the site ..."
a2ensite 000-default-ssl.conf
apachectl configtest

echo "* Restart the service ..."
systemctl restart apache2 && systemctl status apache2

#######################################################