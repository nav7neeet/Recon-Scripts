#!/bin/bash

path=~/Bug-Hunt/$1


if [ "$#" -ne 1 ]; then
  echo 
  echo "Usage: $(basename -- $0) domain"
  echo
  echo "domain: domain to find web apps for"
  echo
  exit
fi

gau -subs $1 | unfurl -u format %s://%d:%P | grep -v ':$\|80$\|443$' > $path/temp/gau-web-apps.txt

waybackurls $1 | unfurl -u format %s://%d:%P | grep -v ':$\|80$\|443$' > $path/temp/wayback-web-apps.txt

cat $path/live-subs.txt | httprobe -prefer-https > $path/temp/httprobe-web-apps.txt

cat $path/temp/gau-web-apps.txt $path/temp/wayback-web-apps.txt $path/temp/httprobe-web-apps.txt | sort -u > $path/web-apps.txt