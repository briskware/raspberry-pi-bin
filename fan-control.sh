#$/bin/bash

speed=$1

if [ -z "$speed" ]
then
  echo "Invalid or missing speed argument, using MAX (4) as default"
  speed=4
fi
  
if [ "$speed" -gt  "4" ]
then
  speed=4
fi

while true
do
  echo -n "$speed" | sudo tee /sys/class/thermal/cooling_device0/cur_state > /dev/null
  sleep 1
  temp=$(cat /sys/devices/virtual/thermal/thermal_zone0/temp)
  #speed=$(cat /sys/class/thermal/cooling_device0/cur_state)
  printf "Temp: %2.1fC Speed: %d\n" $(( $temp / 1000 )) $speed
done

