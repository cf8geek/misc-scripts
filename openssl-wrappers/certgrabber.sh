#!/bin/bash
#stolen from:
#https://stackoverflow.com/questions/7885785/using-openssl-to-get-the-certificate-from-a-server/
if [ -z "$1" ]
then
	echo "need to pass FQDN"
	echo "add --full to see whole thing"
	echo "at which point you might want to put in your own 'grep' statement"
else
	if [[ "--full" == "$2" ]]
	then
		echo | \
			openssl s_client -servername $1 -connect $1:443 2>/dev/null | \
			openssl x509 -text
	else

		echo | \
			openssl s_client -servername $1 -connect $1:443 2>/dev/null | \
			openssl x509 -text | \
				grep -e Issuer: -e After -e Before -e Subject:
	fi
fi
