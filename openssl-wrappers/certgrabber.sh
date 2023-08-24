#!/bin/bash
#stolen from:
#https://stackoverflow.com/questions/7885785/using-openssl-to-get-the-certificate-from-a-server/
if [ -z "$1" ]
then
	echo "need to pass FQDN"
	echo "add --full to see whole thing"
	echo "at which point you might want to put in your own 'grep' statement"
else
	if [[ $(echo $1 | grep -c ':') -eq 0 ]]
 	then
  		#echo "grep found no colons"
    		FQDN=$1
      		PORT=443
	else
 		#echo "grep found more than zero colons"
   		FQDN=`echo -n $1 | cut -d: -f1`
   		PORT=`echo -n $1 | cut -d: -f2`
     	fi
	if [[ "--full" == "$2" ]]
	then
 		#echo "going to try for cert grab now, full"
		echo | \
			openssl s_client -servername $FQDN -connect $FQDN:$PORT 2>/dev/null | \
			openssl x509 -text
	else
 		#echo "going to try for cert grab now, partial"
		echo | \
			openssl s_client -servername $FQDN -connect $FQDN:$PORT 2>/dev/null | \
			openssl x509 -text | \
				grep -e Issuer: -e After -e Before -e Subject:
	fi
fi
