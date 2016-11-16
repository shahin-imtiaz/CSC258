vlib work

vlog -timescale 1ns/1ns airplane.v

vsim control

log {/*}

add wave {/*}

force {go}      0 0, 1 25 -r 50
force {reset_n} 0 0,1 10
force {clock} 0 0,1 3 -r 6
run 500ns
