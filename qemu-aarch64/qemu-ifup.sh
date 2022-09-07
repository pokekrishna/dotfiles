#!/bin/sh 
# 
# script to bring up the tun device in QEMU in bridged mode 
# first parameter is name of tap device (e.g. tap0)
#
# some constants specific to the local host - change to suit your host
#

# set it to your wifi network interface
HOST_ETH_IF="en0"

# Set it to a number which is not already created
HOST_BRIDGE_IF="bridge1"

HOST_MACHINE_ADDR="192.168.255.1/24"

if [ -z $HOST_ETH_IF  ]; then 
    echo "HOST_ETH_IF not set"
    exit 1
fi

if [ -z $HOST_BRIDGE_IF  ]; then 
    echo "HOST_BRIDGE_IF not set"
    exit 1
fi

if [ -z $HOST_MACHINE_ADDR  ]; then 
    echo "HOST_MACHINE_ADDR not set"
    exit 1
fi

ifconfig ${HOST_BRIDGE_IF} down

# Add an alias ip to host's interface. This will be the main 
# communication IP
ifconfig ${HOST_ETH_IF} inet ${HOST_MACHINE_ADDR} alias

# create the bridge interface
ifconfig ${HOST_BRIDGE_IF} create 

# add members to the bridge
ifconfig ${HOST_BRIDGE_IF} addm ${HOST_ETH_IF} addm $1

ifconfig ${HOST_BRIDGE_IF} up
