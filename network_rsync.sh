#!/bin/bash
echo -e >> /var/log/backup.log
echo "Backup for `hostname` started at `date`" >> /var/log/backup.log

rsync -aAX --delete --exclude={"/var/log/","/dev/","/proc/","/sys/","/tmp/","/run/","/mnt/","/media/","/srv/","/lost+found"} / hv1:/backups/network_backup/

STATUS=`echo $?`

if [ "$STATUS" == "0" ]; then
 echo "Backup for `hostname` completed SUCCESSFULLY at `date`" >> /var/log/backup.log
else
 echo "Backed for `hostname` FAILED at `date`" >> /var/log/backup.log
fi
