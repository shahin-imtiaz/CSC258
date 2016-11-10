vlib work

vlog -timescale 1ns/1ns part2.v

vsim control

log {/*}

add wave {/*}

force {go} 1 0, 0 20 -r 40
force {reset_n} 0 0,1 100
force {clock} 0 0,1 5 -r 10
force {KEY} 1 0, 0 10 -r 20
run 500ns