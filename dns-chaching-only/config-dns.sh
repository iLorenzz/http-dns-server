#!/usr/bin/env bash

NAMED_CONF_FILE="named-conf.txt"

named_conf_list=()
while CONF= read -r line
do
    named_conf_list+=("$line")
done < "$NAMED_CONF_FILE"

[ ! -x "$(which bind)" ] && yum install bind -y

systemctl enable named

firewall-cmd --add-service=dns --reload
if [ $? -ne 0  ]; then 
    systemctl enable firewalld
    firewall-cmd --add-service=dns --reload
fi



