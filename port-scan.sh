#!/bin/bash

path=~/Bug-Hunt/$1

# if [ "$EUID" -ne 0 ]
#   then echo "Please run as root"
#   exit
# fi

if [ "$#" -ne 1 ]; then
  echo 
  echo "Usage: $(basename -- $0) domain"
  echo
  echo "domain: domain for port scan"
  echo
  exit
fi

# sudo masscan -iL $path/live-subs-ip.txt --top-ports 5 -oG $path/masscan.log --rate=100 --banner --source-ip 192.168.1.200

sudo masscan -iL $path/live-subs-ip.txt -p21,22,23 -oG $path/masscan.log --rate=50 --banner --source-ip 192.168.1.200