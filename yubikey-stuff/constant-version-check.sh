#!/bin/bash

# grabs version (firmware)
watch -n .2 'ykinfo -v'

# You can use this one instead, if you also want serial number
# but be aware that some older Yubikeys do not support this,
# and thus you will get nothing.
#watch -n .2 'ykinfo -sv'
