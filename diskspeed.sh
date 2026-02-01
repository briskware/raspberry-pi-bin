#!/bin/bash

if [ -z "$1" ]; then
  echo "Will test speed in the current directory, to override run: $(basename $0) <target-directory>"
fi

target_dir="${1:-$(pwd)}"
target_dir="${target_dir%/}"
echo Testing disk speed in directory: ${target_dir}

testfile="$target_dir"/testfile.tmp

# number of 2MB blocks (10 means 20MB)
fileblocks=500

echo Writing file: ${testfile}
write=$(dd if=/dev/zero bs=2048k of=${testfile} count=${fileblocks} 2>&1 |grep bytes| awk '{print $10, $11}')
time sync ${testfile}
echo Reading file: ${testfile}
reads=$(dd if=${testfile} bs=2048k of=/dev/null count=${fileblocks} 2>&1 |grep bytes| awk '{print $10, $11}')
rm ${testfile}

echo Write Speed: ${write}
echo  Read Speed: ${reads}
