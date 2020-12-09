#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo 
  echo "Usage: $(basename -- $0) domain"
  echo
  echo "domain: domain to collect JS files for"
  echo
  exit
fi

path=~/Bug-Hunt/$1/temp

cat $path/gau1.txt | grep '\.js$' > $path/gau-js.txt

waybackurls $1 | grep '\.js$' > $path/wayback-js.txt

cat $path/gau-js.txt $path/wayback-js.txt | sort -u > js-files.txt

cat js-files.txt | grep -v -i 'jquery\|bootstrap\|angular\|carousel\|canvas\|modernizr\|lightbox\|fusionchart\|popper\|retina\|revolution\|superfish\|calendar\|highchart\|smoothscroll\|device\|isotope\|date\|favicon\|spectrum\|orbit\|ajax\|underscore|\respond\|owl' > $path/custom-js.txt

cat temp/custom-js.txt | fff -s 200 -o temp