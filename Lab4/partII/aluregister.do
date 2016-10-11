vlib work

vlog -timescale 1ns/1ns aluregister.v

vsim aluregister

log {/*}

add wave {/*}

#force {KEY[0]} 1
#force {SW[9]} 0
#force {SW[3: 0]} 2#1010
#force {SW[7: 5]} 2#000

#clock
force {KEY[0]} 0 0, 1 5 -r 10
#reset
force {SW[9]} 0 0, 1 10, 0 90, 1 100, 0 180, 1 190
# fix A values
force {SW[3: 0]} 2#0000 0, 2#0011 90, 2#0100 180 -r 270

#  functions, 10ns each:
force {SW[7: 5]} 2#000 00, 2#001 20, 2#010 30, 2#011 40, 2#100 50, 2#101 60, 2#110 70, 2#111 80 -r 90

run 250ns