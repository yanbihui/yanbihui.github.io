#!/bin/bash
#Date: 2016/7/13
#Author: YBH
#Version: 1.0

#database list
cat > /tmp/bak.txt <<EOF
mysql
zabbix
jumpserver
EOF
[ $? -eq 0 ] && echo "Create file success!!!" || echo "Failure to create a file"

# Variable declaration
DBLIST=$(cat /tmp/bak.txt)
DBUSER=root
DBPASS=000000
BAKPATH=/DB_bakup/mysql

# Database backup execution script
for i in $DBLIST
do
  [ ! -d ${BAKPATH}/$i ] &&  mkdir -p ${BAKPATH}/$i
  mysqldump -u$DBUSER -p$DBPASS -x -B -F -R --events $i | gzip > ${BAKPATH}/$i/mysql_${i}_$(date +%F-%T).sql.gz
  [ $? -eq 0 ] && echo "Backup $i database success!!!" || echo "Failure to backup $i database"
done
