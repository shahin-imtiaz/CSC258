vlib work

vlog -timescale 1ns/1ns airplane_try.v

vsim datapath

log {/*}

add wave {/*}

force {clock} 0 0,1 5 -r 10
force {reset_n} 0 0,1 20
force {colour} 2#101
force {enable} 0 0,1 25
force {ld_c}  0 0,1 25
force {signal_1} 1
force {signal_2} 0
run 3000ns