vlib work

vlog -timescale 1ns/1ns try.v

vsim datapath

log {/*}

add wave {/*}

force {enable} 0 0,1 25
force {clock} 0 0,1 2 -r 4
force {ld_c} 0 0,1 25
force {reset_n} 0 0,1 10
force {colour} 2#101
run 10000ns