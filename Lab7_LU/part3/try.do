vlib work

vlog -timescale 1ns/1ns try.v

vsim try

log {/*}

add wave {/*}

force {clock} 0 0,1 2 -r 4
force {reset_n} 0 0,1 10
force {go} 0 0, 1 20 -r 40
force {colour}  3'b101 
run 10000ns 