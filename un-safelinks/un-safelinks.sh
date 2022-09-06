#!/bin/bash
# usage: ./un-safelinks.sh 'https://protection-bla-blah-bla/url-endoded-blah-bla-blah'
echo
echo
echo $1 | sed 's/\&data.*//' | sed 's/https:\/\/nam02.safelinks.protection.outlook.com\/?url=//' | sed 's/%2F/\//g' | sed 's/%3A/:/g' | sed 's/%3F/?/g' | sed 's/%3D/=/g' | sed 's/%25/%/g' 
echo
