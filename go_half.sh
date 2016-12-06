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
yum -y install wget mlocate vim chrony centos-release-openstack-newton git;
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

sudo sed -i '/Allow root to run any commands anywhere/a thn16      ALL=(ALL)       ALL' /etc/sudoers;
sudo sed -i '/Allow root to run any commands anywhere/a zsm5       ALL=(ALL)       ALL' /etc/sudoers;
sudo sed -i '/Allow root to run any commands anywhere/a lewicki    ALL=(ALL)       ALL' /etc/sudoers;
sudo sed -i '/Allow root to run any commands anywhere/a sellison   ALL=(ALL)       ALL' /etc/sudoers;
sudo sed -i '/Allow root to run any commands anywhere/a ellison    ALL=(ALL)       ALL' /etc/sudoers;
sudo sed -i '/Allow root to run any commands anywhere/a dre15      ALL=(ALL)       ALL' /etc/sudoers;
sudo sed -i '/Allow root to run any commands anywhere/a twm18      ALL=(ALL)       ALL' /etc/sudoers;
sudo sed -i '/Allow root to run any commands anywhere/a astrozyk13 ALL=(ALL)       ALL' /etc/sudoers;
sudo sed -i '/Allow root to run any commands anywhere/a mea95      ALL=(ALL)       ALL' /etc/sudoers;

echo "136.142.139.133   controller      controller.cist.pitt.edu" >> /etc/hosts ;
echo "136.142.139.134   network         network.cist.pitt.edu" >> /etc/hosts ;
echo "136.142.139.135   compute         compute.cist.pitt.edu" >> /etc/hosts ;
echo "136.142.139.136   compute2        compute2.cist.pitt.edu" >> /etc/hosts ;
echo "136.142.139.137   compute3        compute3.cist.pitt.edu" >> /etc/hosts ;

sudo sed -i '/PermitRootLogin/a PermitRootLogin yes' /etc/ssh/sshd_config ;
sudo sed -i '/PasswordAuthentication/a PasswordAuthentication yes' /etc/ssh/sshd_config ;
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config ;

wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm;
wait;
rpm -ivh epel-release-7-8.noarch.rpm;
wait;
yum -y install erlang;
wait;
yum -y upgrade;
wait;

echo "***************************************************************************************";
echo "***************************************************************************************";
echo "***************************************************************************************";
echo "***************************************************************************************";
echo "                  REBOOTING IN 10 SECONDS!!!!!!!!!!!!!!!!!!!!!!!                       ";
echo "***************************************************************************************";
echo "***************************************************************************************";
echo "***************************************************************************************";
echo "***************************************************************************************";

sleep 10;
sudo reboot now;

