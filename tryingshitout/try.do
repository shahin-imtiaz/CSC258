vlib work

vlog -timescale 1ns/1ns try.v

vsim try

log {/*}

add wave {/*}

# Testcase 1
force {SW[9: 0]} 2#0000000000

run 20ns

# Testcase 2
force {SW[9: 0]} 2#1111111111

run 20ns

# Testcase 3
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0
force {SW[8]} 1
force {SW[9]} 0

run 20ns
