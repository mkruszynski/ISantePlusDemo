#!/bin/bash

service mysql start
mysql -uroot -e "CREATE DATABASE openmrs"
mysql -uroot -e "GRANT ALL PRIVILEGES ON * . * TO 'root'@'%'"
mysql -uroot -e "UPDATE mysql.user SET Password=PASSWORD('test') WHERE User='root'"
mysql -uroot -e "FLUSH PRIVILEGES"
mysql -uroot -ptest "openmrs" < /root/openmrs_dump.sql

export CATALINA_OPTS="-Xms1024m -Xmx2048m -XX:MaxPermSize=1024m"
/etc/init.d/tomcat7 start

# The container will run as long as the script is running, that's why
# we need something long-lived here
exec tail -f /var/log/tomcat7/catalina.out
