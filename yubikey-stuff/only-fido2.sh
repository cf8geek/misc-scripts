#!/bin/bash
# only FIDO2: enable everything, then disable everything except FIDO2, over USB
#sleep 2
echo enabling all:
ykman config usb -a -f
echo ""
echo ""
sleep 2
echo disabling otp
ykman config usb -d otp -f
echo ""
echo ""
sleep 2
echo disabling u2f
ykman config usb -d u2f -f
echo ""
echo ""
#sleep 2
#echo disabling fido2
#ykman config usb -d fido2 -f
echo ""
echo ""
sleep 2
echo disabling oath
ykman config usb -d oath -f
echo ""
echo ""
sleep 2
echo disabling piv
ykman config usb -d piv -f
echo ""
echo ""
sleep 2
echo disabling openpgp
ykman config usb -d openpgp -f
echo ""
echo ""
sleep 2
echo disabling hsmauth
ykman config usb -d hsmauth -f
echo "done"
ykman info
#EOF
