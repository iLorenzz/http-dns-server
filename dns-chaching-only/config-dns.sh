#!/usr/bin/env bash

[ ! -x "$(which bind)" ] && yum install bind -y

systemctl enable named

firewall-cmd --add-service=dns --reload
if [ $? -ne 0  ]; then 
    systemctl enable firewalld
    firewall-cmd --add-service=dns --reload
fi

