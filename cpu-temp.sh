echo "CPU  Temp: $(vcgencmd measure_temp |cut -d= -f2)"
echo "CPU   Fan: $(cat /sys/class/thermal/cooling_device0/cur_state)"
