#!/bin/bash

path=~/Bug-Hunt/$1

if [ "$#" -ne 1 ]; then
  echo 
  echo "Usage: $(basename -- $0) domain"
  echo
  echo "domain: domain to find live subdomains for"
  echo
  exit
fi

while read subdomain; do
if host "$subdomain" > /dev/null; then
    echo "$subdomain" >> $path/live-subs.txt
    #echo "$subdomain"
fi
done < $path/raw-subs.txt


while read subdomain; do
echo `dig +short $subdomain` | grep -oP "([0-9]{1,3}\.){3}[0-9]{1,3}" >> $path/temp.txt
done < $path/live-subs.txt
cat $path/temp.txt | sort -u > $path/live-subs-ip.txt
mv $path/temp.txt $path/temp