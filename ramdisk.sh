#!/bin/bash

size="${1:-512M}"

echo Creating RAM Disk of size: $size
sudo mkdir -p /mnt/ramdisk
sudo mount -t tmpfs -o size=$size tmpfs /mnt/ramdisk
echo "RAM Disk mounted at: /mnt/ramdisk" > /mnt/ramdisk/README.txt
echo "Created on:          $(date) with size $size" >> /mnt/ramdisk/README.txt
echo "To remove run:       sudo umount /mnt/ramdisk" >> /mnt/ramdisk/README.txt
echo "Free space:          echo $(df -h /mnt/ramdisk | tail -1 | awk '{print $4}')" >> /mnt/ramdisk/README.txt
./breakline.sh
cat /mnt/ramdisk/README.txt
./breakline.sh
echo "Done."
