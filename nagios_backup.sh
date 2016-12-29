#!/bin/bash
unalias cp
cp /root/nagios_backup.sh /root/nagios/nagios_backup.sh
sudo cp -R /usr/lib64/nagios/plugins/* /root/nagios/plugins/
sudo cp -R /etc/nrpe.d/* /root/nagios/nrpe.d/
sudo cp -R /etc/nagios/* /root/nagios/
cd /root/nagios
sudo rm passwd
sudo rm keystonerc_admin
git rm passwd
git rm keystonerc_admin
git add .
git commit -m "Auto backup: `date`"
git push
