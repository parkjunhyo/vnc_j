#! /usr/bin/env bash

if [[ `find /root/.vnc -name *pid | awk -F'[/:.]' '{print $6}'` ]]
then
 set `find /root/.vnc -name *pid | awk -F'[/:.]' '{print $6}'`
 for VNCPID in $@
 do
  vncserver -kill :$VNCPID
  rm -rf /root/.vnc/$(hostname):$VNCPID.log
  echo "VNC ID $VNCPID has been stopped!"
 done
fi


if [[ `ls /root/.vnc/ | grep -i 'pid'` ]]
then
 ## stop and kill vnc process
 set `ls /root/.vnc/*.pid`
 for filename in $@
 do
  # kill process daemon
  kill -9 `cat $filename`
 done

 ## remove vnc file
 rm -rf /tmp/.X*
 rm -rf /root/.vnc/$(hostname)*
fi
