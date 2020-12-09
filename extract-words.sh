#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo 
  echo "Usage: $(basename -- $0) domain"
  echo
  echo "domain: domain to extract custom words for"
  echo
  exit
fi

path=~/Bug-Hunt/$1/temp

mkdir $path/fff
mkdir $path/gau

cat $path/web-apps.txt | fff -s 200 -s 404 -o $path/fff

cat $path/fff/*/* | tok | sort -u > $path/fff.txt



gau -subs $1 | sort -u > $path/gau1.txt

cat $path/gau1.txt | grep -v '\.png$\|\.jpeg$\|\.jpg$\|\.pdf$\|\.gif$\|\.css$\|\.woff$\|\.ico$' | sort -u > $path/gau2.txt

cat $path/gau2.txt | unfurl -u format %s://%d:%P%p > $path/gau3.txt

cat $path/gau3.txt | head -n 1000 | fff -s 200 -s 404-o $path/gau

cat $path/gau/*/* | tok | sort -u > $path/gau4.txt

cat $path/fff.txt $path/gau4.txt | sort -u > $path/custom-words.txt