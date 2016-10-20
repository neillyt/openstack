#!/bin/bash

echo "What is the hostname? Do not include '.cist.pitt.edu'";
echo "Good Example: awesomebox";
echo "Bad Example: awesomebox.cist.pitt.edu";
read hostname;
echo ""

systemctl stop NetworkManager;
systemctl disable NetworkManager;
systemctl stop firewalld;
systemctl disable firewalld;

wait;
yum -y install wget mlocate vim chrony centos-release-openstack-liberty;
wait;
yum -y install python-openstack client openstack-packstack;
wait;
yum -y group install "Virtualization" "Virtualization Client" "Virtualization Hypervisor" "Virtualization Platform" "Virtualization Tools" "X Window System" "GNOME";
wait;

systemctl start chronyd;
systemctl enable chronyd;

echo "$hostname.cist.pitt.edu" > /etc/hostname;

useradd thn16 -p `openssl passwd -crypt 123`;
useradd zsm5 -p `openssl passwd -crypt 123`;
useradd lewicki -p `openssl passwd -crypt 123`;
useradd sellison -p `openssl passwd -crypt 123`;
useradd ellison -p `openssl passwd -crypt 123`;
useradd dre15 -p `openssl passwd -crypt 123`;
useradd twm18 -p `openssl passwd -crypt 123`;
useradd astrozyk13 -p `openssl passwd -crypt 123`;
useradd mea95 -p `openssl passwd -crypt 123`;

echo "OS_USERNAME=admin" >> /etc/environment;
echo "OS_PASSWORD=Panther$" >> /etc/environment;
echo "OS_AUTH_URL=http://controller.cist.pitt.edu:5000/v2.0" >> /etc/environment;
echo "OS_PROJECT_NAME=admin" >> /etc/environment;
source /etc/environment;

OS_USERNAME=admin;
OS_PASSWORD=Panther$;
OS_AUTH_URL=http://controller.cist.pitt.edu:5000/v2.0;
OS_PROJECT_NAME=admin;

export OS_USERNAME=admin;
export OS_PASSWORD=Panther$;
export OS_AUTH_URL=http://controller.cist.pitt.edu:5000/v2.0;
export OS_PROJECT_NAME=admin;

cd /;
git init;
git clone https://github.com/neillyt/openstack.git;


echo "136.142.139.140   controller      controller.cist.pitt.edu" >> /etc/hosts ;
echo "136.142.139.141   network         network.cist.pitt.edu" >> /etc/hosts ;
echo "136.142.139.142   compute         compute.cist.pitt.edu" >> /etc/hosts ;
echo "136.142.139.143   compute2        compute2.cist.pitt.edu" >> /etc/hosts ;
echo "136.142.139.144   compute3        compute3.cist.pitt.edu" >> /etc/hosts ;

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config;
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config;

wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm;
wait;
rpm -ivh epel-release-7-8.noarch.rpm;
wait;

yum -y upgrade;
wait;

echo "***************************************************************************************";
echo "***************************************************************************************";
echo "***************************************************************************************";
echo "***************************************************************************************";
echo " ALL HOSTS: Disable selinux in /etc/selinux/config";
echo " CONTROLLER: yum -y install erlang";
echo " CONTROLLER: packstack --gen-answer-file /root/answers.txt";
echo "***************************************************************************************";
echo "***************************************************************************************";
echo "***************************************************************************************";
echo "***************************************************************************************";


