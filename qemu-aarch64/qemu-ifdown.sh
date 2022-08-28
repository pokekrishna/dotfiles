#!/bin/sh 
# 
# script to bring up the tun device in QEMU in bridged mode 
# first parameter is name of tap device (e.g. tap0)
#
# some constants specific to the local host - change to suit your host
#

# Set it to a number which is not already created
HOST_BRIDGE_IF="bridge1"

if [ -z $HOST_BRIDGE_IF  ]; then 
    echo "HOST_BRIDGE_IF not set"
    exit 1
fi

ifconfig ${HOST_BRIDGE_IF} destroy