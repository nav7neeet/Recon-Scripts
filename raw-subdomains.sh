#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo 
  echo "Usage: $(basename -- $0) domain"
  echo
  echo "domain: domain to find subdomains for"
  echo
  exit
fi

mkdir ~/Bug-Hunt/$1
mkdir ~/Bug-Hunt/$1/temp
path=~/Bug-Hunt/$1/temp
domain=$1


echo "** Github-Search Started"
cd ~/Tools/github-search
source ./env/bin/activate
python3 github-subdomains.py -t <Github Token> -d $domain > $path/github-search.txt
echo "** Github-Search Finished"
echo


echo "** Subfinder Started"
subfinder -d $domain -silent -o $path/subfinder.txt
echo "** Subfinder Finished"
echo


echo "** Archived URLs Started"
gau -subs bihar.gov.in | unfurl -u domains > $path/gau.txt
waybackurls bihar.gov.in | unfurl -u domains > $path/wayback.txt
cat $path/gau.txt $path/wayback.txt | sort -u > $path/archived.txt
echo "** Archived URLs Finished"
echo


## DNS Resolvers ##
dnsvalidator -tL ~/Payloads/best-resolvers.txt --silent > $path/temp.txt
head -n 20 $path/temp.txt > $path/resolvers.txt
echo


echo "**Amass Started"
cp ~/.config/amass.config $path
mv $path/amass.config $path/config.ini
amass enum -d $domain -active -silent -brute -w /usr/share/amass/wordlists/deepmagic.com_top500prefixes.txt -rf $path/resolvers.txt -max-dns-queries 1000 -dir $path -o $path/amass.txt
echo  "**Amass Finished"
echo


cat $path/amass.txt $path/subfinder.txt $path/github-search.txt $path/archived.txt | sort -u > $path/../raw-subs.txt
