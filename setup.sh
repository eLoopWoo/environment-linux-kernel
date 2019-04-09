#!/usr/bin/env bash

function welcome(){
        base64 "misc/logo$(( ( RANDOM %  $(ls misc/ | grep logo | wc -l)  ) ))" --decode

	echo "** Linux Kernel Research **"
	if [[ $EUID -ne 0 ]]; then
		echo "This script must be run as root"
		exit 1
	fi

	if [ -z "$1" ]; then
		echo "usage: ./setup username"
		exit 1
	fi

}

function download_kernel(){
	echo "Downloading kernel..."
	wget -c https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.16.3.tar.xz
	tar -xvJf linux-4.16.3.tar.xz
	rm linux-4.16.3.tar.xz
}

function download_busybox(){
	echo "Downloading busybox..."
	wget -c http://busybox.net/downloads/busybox-1.28.3.tar.bz2
	tar -xvjf busybox-1.28.3.tar.bz2
	rm busybox-1.28.3.tar.bz2
}

function download_qemu(){
	echo "Downloading qemu..."
	apt-get install qemu
}

function download_bison(){
	echo "Downloading bison..."
	apt-get install bison
}

function download_flex(){
	echo "Downloading flex..."
	apt-get install flex
}

function download_libs(){
	echo "Downloading libs..."
	apt-get install libelf-dev
       	apt-get install libelf-devel
        apt-get install elfutils-libelf-devel
}

function download(){
	download_qemu
	download_bison
	download_flex
	download_libs
	download_kernel
	download_busybox
	chmod 775 *
	chown -R $1 *
	chgrp -R $1 *
}

function compile_kernel(){
	cd linux-4.16.3/
	make clean && make mrproper
	cat /boot/config-$(uname -r) > .config
	make defconfig
	./scripts/kconfig/merge_config.sh .config ../config-fragment
	sed -i "s/KBUILD_CFLAGS   += -O0"/"KBUILD_CFLAGS   += -O2/g" Makefile
	echo "Compiling kernel..."
	make -j 4
	cd ..
	echo "Finished compiling kernel..."
}

function compile_busybox(){
	cd busybox-1.28.3/
	make defconfig
	sed -i "s/# CONFIG_STATIC is not set/CONFIG_STATIC=y/g" .config
	echo "Compiling busybox..."
	make
	make install
	echo "Finished compiling busybox..."
	mkdir initramfs
	cd initramfs
	cp ../_install/* -rf ./
	mkdir dev proc sys
	cp -a /dev/null /dev/console /dev/tty /dev/tty2 /dev/tty3 /dev/tty4 dev/
	rm linuxrc
	echo "#!/bin/busybox sh" > init
	echo "mount -t proc none /proc" >> init
	echo "mount -t sysfs none /sys" >> init
	echo "exec /sbin/init" >> init
	find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz

}

function main(){
	welcome $1
	download $1
	compile_kernel
	compile_busybox
}

main $1
