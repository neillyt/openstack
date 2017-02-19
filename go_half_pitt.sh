#!/bin/bash

echo "What is the hostname? Do not include '.cist.pitt.edu'";
echo "Good Example: awesomebox";
echo "Bad Example: awesomebox.cist.pitt.edu";
read hostname;
echo "";
echo "Enter the full IP address:";
read ip;


systemctl stop NetworkManager;
systemctl disable NetworkManager;
systemctl stop firewalld;
systemctl disable firewalld;

yum -y install epel-release;
yum -y install wget mlocate vim chrony centos-release-openstack-liberty git;
yum -y install python-openstackclient openstack-packstack;
yum -y install erlang tigervnc tigervnc-server;
yum -y group install "Virtualization" "Virtualization Client" "Virtualization Hypervisor" "Virtualization Platform" "Virtualization Tools"
# yum -y group install "X Windows Server" "GNOME"
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

#echo 'DEVICE="br0"' > /etc/sysconfig/network-scripts/ifcfg-br0
#echo 'ONBOOT="yes"' >> /etc/sysconfig/network-scripts/ifcfg-br0
#echo 'TYPE="Bridge"' >> /etc/sysconfig/network-scripts/ifcfg-br0
#echo 'BOOTPROTO="none"' >> /etc/sysconfig/network-scripts/ifcfg-br0
#echo 'IPADDR="$ip"' >> /etc/sysconfig/network-scripts/ifcfg-br0
#echo 'NETMASK="255.255.255.224"' >> /etc/sysconfig/network-scripts/ifcfg-br0
#echo 'GATEWAY="136.142.139.129"' >> /etc/sysconfig/network-scripts/ifcfg-br0
#echo 'DNS1="136.142.57.10"' >> /etc/sysconfig/network-scripts/ifcfg-br0
#echo 'DNS2="8.8.8.8"' >> /etc/sysconfig/network-scripts/ifcfg-br0
#echo 'STP="on"' >> /etc/sysconfig/network-scripts/ifcfg-br0
#echo 'DELAY="0"' >> /etc/sysconfig/network-scripts/ifcfg-br0

#echo 'DEVICE=em1' > /etc/sysconfig/network-scripts/ifcfg-em1
#echo 'ONBOOT=yes' >> /etc/sysconfig/network-scripts/ifcfg-em1
#echo 'BRIDGE="br0"' >> /etc/sysconfig/network-scripts/ifcfg-em1


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
