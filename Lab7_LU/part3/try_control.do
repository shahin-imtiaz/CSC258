vlib work

vlog -timescale 1ns/1ns try.v

vsim control

log {/*}

add wave {/*}

force {clock} 0 0,1 5 -r 10
force {reset_n} 0 0,1 10
force {go} 0 0, 1 15 -r 30
run 1000ns 