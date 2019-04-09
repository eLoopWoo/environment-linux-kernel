
define xhelp
printf "\tx_start - connect to remote target, set breakpoint and split layout\n"
printf "---------------\n"
printf "\txis - info shared\n"
printf "---------------\n"
printf "\txi - x/10i $pc - 10\n"
printf "---------------\n"
printf "\txx - show current state\n"
printf "---------------\n"
printf "\txsi - single step and show current state\n"
printf "---------------\n"
printf "\txni - next step and show current state\n"
printf "---------------\n"
end

define xis
info shared
end

define xi
x/10i $pc - 10
end

define xx
printf "---------------\n"
x/10gx $sp
printf "---------------\n"
info reg
printf "---------------\n"
x/20i $pc - 0x10
printf "---------------\n"
info frame
printf "---------------\n"
end

define xni
ni
printf "---------------\n"
x/10gx $sp
printf "---------------\n"
info reg
printf "---------------\n"
x/20i $pc - 0x10
printf "---------------\n"
info frame
printf "---------------\n"
end

define xsi
si
printf "---------------\n"
x/10gx $sp
printf "---------------\n"
info reg
printf "---------------\n"
x/20i $pc - 0x10
printf "---------------\n"
info frame
printf "---------------\n"
end

define x_start
	target remote localhost:1234
	file linux-4.16.3/vmlinux
	set disassembly-flavor intel
	layout split
	b cmdline_proc_show
end
