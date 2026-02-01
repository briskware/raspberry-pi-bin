echo CPU Speed: $(( $(vcgencmd measure_clock arm|cut -d= -f2) / 1000000 )) MHz
echo GPU Speed: $(( $(vcgencmd measure_clock core|cut -d= -f2) / 1000000 )) MHz

