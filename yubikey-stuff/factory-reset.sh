#!/bin/bash

# NOTE:
# FIDO2 resets require reinserting/touching the key; you can comment that line out if you want a more automated approach, without resetting FIDO2

# find version, serial, if available:
# ykinfo -sv
# but since that fails on older Yubikeys, let's do them separate:
ykinfo -s
ykinfo -v

# Reset guides
# https://support.yubico.com/hc/en-us/articles/360013757959-Resetting-Your-YubiKey-5-Series-to-Factory-Defaults

# OTP:
## https://support.yubico.com/hc/en-us/articles/360013647680-Resetting-the-OTP-Applet-on-the-YubiKey
yes | ykman otp delete 1
yes | ykman otp delete 2

# FIDO2
## https://support.yubico.com/hc/en-us/articles/360016648899-Resetting-the-FIDO2-Application-on-Your-YubiKey-or-Security-Key
yes | ykman fido reset

# PIV:
## https://support.yubico.com/hc/en-us/articles/360013645480-Resetting-the-Smart-Card-PIV-Applet-on-Your-YubiKey
yes | ykman piv reset

# OATH:
## https://support.yubico.com/hc/en-us/articles/360013712719-Resetting-the-OATH-Applet-on-the-YubiKey
yes | ykman oath reset

# OpenPGP
## https://support.yubico.com/hc/en-us/articles/360013761339-Resetting-the-OpenPGP-Applet-on-the-YubiKey
yes | ykman openpgp reset
