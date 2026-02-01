echo CPU Volts: $(vcgencmd measure_volts core|cut -d= -f2)

