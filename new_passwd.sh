#!/usr/bin/expect

#origin 
set ipaddr [lindex $argv 0]
set oldpass [lindex $argv 1]
set newpass [lindex $argv 2]

spawn ssh root@$ipaddr

expect "(yes/no)?"
send "yes\r"

expect "password:"
send "$oldpass\r"

expect "#"
send "passwd --stdin root\r"

expect "root."
send "$newpass\r"

expect "#"
send "exit\r"

expect eof

## passchg.sh
#! /bin/bash
while read line
do
    ipaddr=`echo $line | awk '{print $1}'`
    oldpass=`echo $line | awk '{print $2}'`
    newpass=`echo $line | awk '{print $3}'`
    rm -f /root/.ssh/*
    ./expect.sh $ipaddr $oldpass $newpass
done < serverlist.txt

## serverlist.txt
192.168.1.101 o65|Hn*) WS7Y/khl71d
192.168.1.102 LY{CRk?1 Z{-5uqrMWo!

#
# root 접속 불가 
#
#!/usr/bin/expect 
 
set ipaddr [lindex $argv 0] 
set ippbxold [lindex $argv 1] 
set ippbxnew [lindex $argv 2] 
set rootold [lindex $argv 3] 
set rootnew [lindex $argv 4] 
 
spawn ssh ippbx@$ipaddr 
set timeout 120 
expect "(yes/no)?" 
send "yes\r" 
 
expect "password:" 
send "$ippbxold\r" 
 
expect "\\\$" 
send "su\r" 
expect "암호:" 
send "$rootold\r" 
 
expect "#" 
send "passwd --stdin ippbx\r" 
expect "ippbx." 
send "$ippbxnew\r" 
 
expect "#" 
send "passwd --stdin root\r" 
expect "root." 
send "$rootnew\r" 
 
expect "#" 
send "exit\r" 
 
expect "\\\$" 
send "exit\r" 
 
expect eof

