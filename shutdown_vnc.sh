#! /usr/bin/env bash

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
