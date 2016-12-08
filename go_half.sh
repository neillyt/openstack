#!/bin/bash

echo "What is the hostname? Do not include '.learnwithlinux.com'";
echo "Good Example: awesomebox";
echo "Bad Example: awesomebox.learnwithlinux.com";
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

echo "$hostname.learnwithlinux.com" > /etc/hostname;

echo "192.168.0.100   controller      controller.learnwithlinux.com" >> /etc/hosts ;
echo "192.168.0.101   network         network.learnwithlinux.com" >> /etc/hosts ;
echo "192.168.0.102   compute         compute.learnwithlinux.com" >> /etc/hosts ;
echo "192.168.0.103   compute2        compute2.learnwithlinux.com" >> /etc/hosts ;
echo "192.168.0.104   compute3        compute3.learnwithlinux.com" >> /etc/hosts ;

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

