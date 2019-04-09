#!/usr/bin/env bash

qemu-system-x86_64 -s -S -kernel `pwd`/linux-4.16.3/arch/x86_64/boot/bzImage -initrd `pwd`/busybox-1.28.3/initramfs.cpio.gz -nographic -append "console=ttyS0"
