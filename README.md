# environment-linux-kernel
Research environment for the linux kernel

### Synopsis

The project is set of script and tools that help to start researching the linux kernel

### Motivation

Couriosity dive to system internals, os inner workings and kernel driver security

## Getting Started

Check 'Prerequisities' section and follow the instruction of 'Installing' section!

### Prerequisities

What things you need

```
Linux Ubuntu/Debian x86-64
git
```

### Installing
A step by step series of examples that tell you have to get a development env running.

`setup.sh` will download, configure and build the linux kernel aswell install the necessary tools

## Example Use
The project consists mostly bash scripts you just run to automate development cycles.

* setup.sh


Download, configure and build the kernel source aswell install the necessary tools

* kernel_run.sh


Boot the kernel

* gdb_run.sh


After the kernel boots, this script will launch gdb.
Connect to localhost port 1234 with gdb to start debugging the kernel


`target remote localhost:1234`






