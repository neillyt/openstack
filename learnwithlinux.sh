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

echo "$hostname.learnwithlinux.com" > /etc/hostname;

git init;
git clone https://github.com/neillyt/openstack.git;

echo "192.168.0.110   controller      controller.learnwithlinux.com" >> /etc/hosts ;
echo "192.168.0.111   network         network.learnwithlinux.com" >> /etc/hosts ;
echo "192.168.0.112   compute         compute.learnwithlinux.com" >> /etc/hosts ;
echo "192.168.0.113   compute2        compute2.learnwithlinux.com" >> /etc/hosts ;
echo "192.168.0.114   compute3        compute3.learnwithlinux.com" >> /etc/hosts ;

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


