#!/bin/bash
#stolen from:
#https://stackoverflow.com/questions/7885785/using-openssl-to-get-the-certificate-from-a-server/
if [ -z "$1" ]
then
	echo "need to pass FQDN"
	echo "PROTIP: grep for 'After' to see expiry"
else
	echo | \
		openssl s_client -servername $1 -connect $1:443 2>/dev/null | \
		openssl x509 -text | \
  			grep -e Issuer: -e After -e Before -e Subject:
fi
