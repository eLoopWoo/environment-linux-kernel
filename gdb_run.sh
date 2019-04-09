#!/usr/bin/env bash

#gdb -ex "target remote localhost:1234" `pwd`/linux-4.16.3/vmlinux
gdb -tui -e `pwd`/linux-4.16.3/vmlinux -x util_gdb.sh
