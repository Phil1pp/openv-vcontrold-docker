#!/bin/bash
sleep 3
USB_DEVICE=/dev/vitocal
echo "Device ${USB_DEVICE}"
# make device accessable
chmod 777 ${USB_DEVICE}
vcontrold -x /config/vcontrold.xml -P /var/run/vcontrold.pid

status=$?
pid=$(pidof vcontrold)
if [ $status -ne 0 ];then
	echo "Failed to start vcontrold"
fi

echo "vcontrold gestartet"
echo "PID: $pid"
while sleep 600; do
	if [ -e /var/run/vcontrold.pid ]; then
		:
	else
		echo "vcontrold.pid nicht vorhanden, exit 0"
		exit 0
	fi
done

