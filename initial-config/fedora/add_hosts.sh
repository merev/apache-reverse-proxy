#!/bin/bash

echo "* Add hosts ..."
echo "192.168.100.161 vm1" >> /etc/hosts
echo "192.168.100.162 vm2" >> /etc/hosts
echo "192.168.100.163 vm3" >> /etc/hosts
echo "192.168.100.164 vm4" >> /etc/hosts

echo "* Add nameserver ..."
echo "nameserver 8.8.8.8" | tee -a /etc/resolv.conf