for i in `cat /etc/hosts | awk '{print $2}' | grep -v localhost`;do scp $1 $i:$2;done;
