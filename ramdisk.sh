#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$script_dir/lib.sh"

size="${1:-512M}"

echo Creating RAM Disk of size: $size
sudo mkdir -p /mnt/ramdisk
sudo mount -t tmpfs -o size=$size tmpfs /mnt/ramdisk
echo "RAM Disk mounted at: /mnt/ramdisk" > /mnt/ramdisk/README.txt
echo "Created on:          $(date) with size $size" >> /mnt/ramdisk/README.txt
echo "To remove run:       sudo umount /mnt/ramdisk" >> /mnt/ramdisk/README.txt
echo "Free space:          $(df -hv /mnt/ramdisk)" >> /mnt/ramdisk/README.txt
breakline
cat /mnt/ramdisk/README.txt
breakline
echo "Done."
