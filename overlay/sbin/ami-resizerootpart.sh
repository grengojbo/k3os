ROOTDEV="xvda"
ROOTPART="xvda1"
LOGFILE="/var/log/resizerootfs.log"
rootdevsize=$(blockdev --getsize /dev/${ROOTDEV})
rootpartsize=$(blockdev --getsize /dev/${ROOTPART})
if ! grep -q ${ROOTPART} /proc/partitions
then
  # EBS volume is unpartitioned ... no work for us
  echo "Unpartitioned EBS volume no need to run" >>$LOGFILE
  return 0
fi
# Check if raw EBS device and partition differ by more than 10MB
if [ ! $(($rootdevsize-$rootpartsize)) -ge 10485760 ]
then
  # No need to resize
  echo "EBS partition is <=10MB of the device size; no need to act" >>$LOGFILE
  return 0
fi
# Resize root partition
/sbin/parted ---pretend-input-tty /dev/${ROOTDEV} resizepart 1 yes 100%
if [ ! $? -eq 0 ]
then
  echo "Resize failed" >>$LOGFILE
  return 0
fi
echo "Successfully resized rootfs!" >>$LOGFILE
# Force fsck on next reboot
/usr/bin/touch /forcefsck
# Disable myself job done
rm /etc/rc5.d/S05ami-resizerootpart.sh
sync
reboot