vlib work

vlog -timescale 1ns/1ns try.v

vsim try

log {/*}

add wave {/*}

# load_val
force {SW[0]} 1 0, 0 40
# in
force {SW[1]} 0 0, 1 40
# load_n
force {SW[6]} 1 0, 0 20 -r 40
# shift
force {SW[7]} 1 0, 0 10 -r 20
# clk
force {SW[8]} 0 0, 1 5 -r 10
# reset_n
force {SW[9]} 1

run 40ns

