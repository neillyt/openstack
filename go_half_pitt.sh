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

yum -y install epel-release;
yum -y install wget mlocate vim chrony centos-release-openstack-liberty git;
yum -y install python-openstack client openstack-packstack;
yum -y install erlang tigervnc tigervnc-server;
yum -y group install "Virtualization" "Virtualization Client" "Virtualization Hypervisor" "Virtualization Platform" "Virtualization Tools" "X Window System" "GNOME";
yum -y upgrade;

systemctl start chronyd;
systemctl enable chronyd;

hostnamectl set-hostname "$hostname.cist.pitt.edu"

#echo "192.168.0.100   controller      controller.learnwithlinux.com" >> /etc/hosts ;
#echo "192.168.0.101   network         network.learnwithlinux.com" >> /etc/hosts ;
#echo "192.168.0.102   compute         compute.learnwithlinux.com" >> /etc/hosts ;
#echo "192.168.0.103   compute2        compute2.learnwithlinux.com" >> /etc/hosts ;
#echo "192.168.0.104   compute3        compute3.learnwithlinux.com" >> /etc/hosts ;

sudo sed -i '/PermitRootLogin/a PermitRootLogin yes' /etc/ssh/sshd_config ;
sudo sed -i '/PasswordAuthentication/a PasswordAuthentication yes' /etc/ssh/sshd_config ;
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config ;

cp /usr/lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@.service;

systemctl set-default graphical.target;
sed -i 's/USER/root/g' /etc/systemd/system/vncserver\@.service
systemctl enable vncserver@:1.service

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
