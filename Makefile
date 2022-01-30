all: make run exec

make:
	docker build . -t yubikey-test

run:
	docker run -ti --rm \
	    -v /dev/bus/usb:/dev/bus/usb \
	    -v /sys/bus/usb/:/sys/bus/usb/ \
	    -v /sys/devices/:/sys/devices/ \
	    -v /dev/hidraw12/:/dev/hidraw12/ \
	    --privileged \
	    yubikey-test \
	    bash

exec:
	docker run --entrypoint bash -ti --rm \
	    -v /dev/bus/usb:/dev/bus/usb \
	    -v /sys/bus/usb/:/sys/bus/usb/ \
	    -v /sys/devices/:/sys/devices/ \
	    -v /dev/hidraw12/:/dev/hidraw12/ \
	    --privileged \
	    yubikey-test

clean:
	docker rmi yubikey-test
