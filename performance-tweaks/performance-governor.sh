#!/bin/bash
# lives at:
# /opt/scripts/performance-governor.sh
echo 'setting now:'
echo
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo
echo
echo
echo 'echoing now:'
echo
sudo cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo
echo
echo
echo 'done'
