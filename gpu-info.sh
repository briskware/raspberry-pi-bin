echo GPU Volts: $( vcgencmd measure_volts core | cut -d= -f2 )
echo GPU Clock: $(( $(vcgencmd measure_clock core|cut -d= -f2) / 1000000 )) MHz
