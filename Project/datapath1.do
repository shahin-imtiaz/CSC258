vlib work

vlog -timescale 1ns/1ns obstacle.v

vsim datapath1

log {/*}

add wave {/*}

force {enable} 0 0,1 25
force {clock} 0 0,1 5 -r 10
force {ld_c} 0 0,1 25
force {reset_n} 0 0,1 10
force {colour} 2#101
force {x} 8'd10
force {y} 8'd20
run 20000ns
