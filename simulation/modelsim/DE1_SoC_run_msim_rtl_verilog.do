transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/10737/Desktop/lab6/lab6 {C:/Users/10737/Desktop/lab6/lab6/mainControl.sv}

