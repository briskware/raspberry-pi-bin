#!/bin/bash

function monitor_system() {
    breakline.sh \
        && cpu-speed.sh \
        && cpu-temp.sh \
        && cpu-volts.sh \
    && breakline.sh \
        && gpu-info.sh \
    && breakline.sh \
        && mem-info.sh \
    && breakline.sh
}

if [ "$1" == "--once" ]; then
    monitor_system
    exit 0
fi

watch -n 1 "$0 --once"
