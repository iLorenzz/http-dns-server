#!/usr/bin/env bash

NAMED_CONF_CONTENT_FILE="named-conf.txt" #$1
NAMED_CONF_FILE="/etc/named.conf"

#named_conf_list=()
#while CONF= read -r line
#do
#    named_conf_list+=("$line")
#done < "$NAMED_CONF_FILE"

yum update -y

[ ! -x "$(which bind)" ] && yum install bind -y

systemctl enable named
systemctl start named

firewall-cmd --add-service=dns --permanent
if [ $? -ne 0  ]; then 
    systemctl enable firewalld
    systemctl start firewalld
    firewall-cmd --add-service=dns --permanent
fi
firewall-cmd --reload

cat $NAMED_CONF_CONTENT_FILE > $NAMED_CONF_FILE
systemctl restart named

named-checkconf