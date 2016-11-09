vlib work

vlog -timescale 1ns/1ns part2.v

vsim control

log {/*}

add wave {/*}

force {go} 1 0, 0 25 -r 50
force {reset_n} 0 0, 1 100
force {clk} 0 0, 1 4 -r 8
force {start} 1
force {}