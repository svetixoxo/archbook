#!/bin/bash

# Load average (1, 5, 15 min)
read one five fifteen _ < /proc/loadavg
load_avg="<b>$one</b> $five $fifteen"

# CPU-Auslastung in Prozenz
cpu_usage=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f%%", usage}')

# Genutzter RAM in GB
mem_used=$(LANG=C free -h | awk '/Mem:/ {print $3}' | sed 's/i//')

# Freier Speicherplatz auf Festplatte
disk_free=$(df -h / | awk 'NR==2 {print $4}')

# Ausgabie
echo "$load_avg | <b>$mem_used</b> | $disk_free"

# JSON-Ausgabe mit Load average als Tooltip
# echo "{\"text\":\"$cpu_usage | $mem_used | $disk_free\", \"tooltip\":\"$one $five $fifteen\"}"
