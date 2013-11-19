#! /usr/bin/env bash

working_directory=$(pwd)
source $working_directory/vnc.env

## start with monitor size
monitor_size=${monitor_size:="1600x900"}
vncserver -geometry $monitor_size

