BUILDPATH := /home/etna/Cyber/Projects/Research/LinuxKernel/research-linux-kernel/linux-4.16.3
obj-m += hello.o

all:
	make -C $(BUILDPATH) M=$(PWD) modules

clean:
	make -C $(BUILDPATH) M=$(PWD) clean
