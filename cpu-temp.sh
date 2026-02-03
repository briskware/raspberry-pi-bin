echo "CPU  Temp: $(vcgencmd measure_temp |cut -d= -f2)"
if [ -f /sys/class/thermal/cooling_device0/cur_state ]; then
    cho "CPU   Fan: $(cat /sys/class/thermal/cooling_device0/cur_state 2>/dev/null)"
fi
