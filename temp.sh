#!/bin/bash

output=$(gau -subs bihar.gov.in | unfurl -u format %s://%d:%P | grep -v ':$\|80$\|443$')

cat $output