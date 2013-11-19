#! /usr/bin/env bash

working_directory=$(pwd)
source $working_directory/vnc.env

## setup gnome-core
if [ ! -d "/etc/gnome/" ]
then
 apt-get install gnome-core -y
fi

## setup vnc4server
if [[ ! `which vncserver` ]]
then
 apt-get install vnc4server -y
fi

## setup expect for insert password
if [[ ! `which expect` ]]
then
 apt-get install expect -y
fi

## set the initially password
if [ ! -d "/root/.vnc/" ]
then
 cmd=`find / -name insert_pass.exp`
 $cmd
fi

## kill all vnc process
cmd=`find / -name shutdown_vnc.sh`
$cmd

## configuration for vnc server
if [[ ! `cat /root/.vnc/xstartup | grep -i "gnome-session"` ]]
then
 ## create temporay 
 temp_file=/tmp/$(date +%Y%m%d%H%M%S)
 touch $temp_file
 chmod 755 $temp_file
 chown root.root $temp_file
 ## change configuration
 echo "gnome-session --session=gnome-classic &" >> /root/.vnc/xstartup
 cat /root/.vnc/xstartup | awk '{if($0~/# unset/){print $2" "$3}else if($0~/x-/){print "#"$0;}else{print $0;}}' > $temp_file
 cp $temp_file /root/.vnc/xstartup
fi

## start with monitor size
monitor_size=${monitor_size:="1600x900"}
vncserver -geometry $monitor_size

## installation clean
## sudo dpkg --configure -a
## sudo apt-get install -f
## sudo apt-get remove --purge getdeb-repository
