#!/bin/bash
set -e

if [ $(whoami) != "root" ]
then
	echo "This script must be run as root."
	exit 1
fi

if [[ $# -eq 0 ]] ; then
    echo 'please tell me the device to resize as the first parameter, like sda for /dev/sda'
    exit 1
fi


if [[ $# -eq 1 ]] ; then
    echo 'please tell me the partition number to resize as the second parameter, like 1 in case you mean /dev/sda1 or 4, if you mean /dev/sda2'
    exit 1
fi

DEVICE=$1
PARTNR=$2

start=$(cat /sys/block/${DEVICE}/${DEVICE}${PARTNR}/start)
end=$(($start+$(cat /sys/block/${DEVICE}/${DEVICE}${PARTNR}/size)))
newend=$(($(cat /sys/block/${DEVICE}/size)-8))

nsize=`expr $newend - $end`

echo "Resize to ${nsize}"

if [ "$nsize" -ne "25" ]
then
  #CURRENTSIZE=`expr $end / 1024`
  #MAXSIZEMB=`printf %s\\n 'unit MB print list' | parted | grep "Disk ${DEVICE}" | cut -d' ' -f3 | tr -d MB`
  echo "Resize /dev/${DEVICE}${PARTNR}"
  /usr/bin/growpart /dev/${DEVICE} ${PARTNR}
  /usr/sbin/resize2fs /dev/${DEVICE}${PARTNR}
#else
#  echo "no change..."
fi


