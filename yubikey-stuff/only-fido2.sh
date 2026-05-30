#!/bin/bash
# only FIDO2: enable everything, then disable everything except FIDO2, over USB
ykman config usb -a -f
ykman config usb -d otp -f
ykman config usb -d u2f -f
#ykman config usb -d fido2 -f
ykman config usb -d oath -f
ykman config usb -d piv -f
ykman config usb -d openpgp -f
ykman config usb -d hsmauth -f
echo "done"
#EOF
