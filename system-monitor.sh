#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$script_dir/lib.sh"


function monitor_system() {
    breakline \
        && cpu-speed.sh \
        && cpu-temp.sh \
        && cpu-volts.sh \
    && breakline \
        && gpu-info.sh \
    && breakline \
        && mem-info.sh \
    && breakline
}

if [ "$1" == "--once" ]; then
    monitor_system
    exit 0
fi

watch -n 1 "$0 --once"
