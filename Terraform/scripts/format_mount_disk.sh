#!/usr/bin/env bash

sdb_check=$(/bin/lsblk | grep sdb | wc -l)
if ([ "${sdb_check}" -eq 1 ]) then
    /bin/echo -e "n\np\n1\n\n\nw" | sudo fdisk /dev/sdb
    /sbin/partprobe
    mkfs.xfs /dev/sdb1
    mkdir -p /data
    echo '/dev/sdb1       /data   xfs     defaults    0 0' >> /etc/fstab
    mount -a
fi
