# Set the working dir, where all compiled Verilog goes.
vlib mux4to1

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns mux4to1.v

# Load simulation using mux as the top level simulation module.
vsim mux4to1

log {/*}

add wave {/*}

# set all input u, v, w, x as constants
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1

# case 1: switch s_0 = 0; s_1 = 0;
# output should be the same as u
force {SW[9]} 0
force {SW[8]} 0

run 10ns

# case 2: switch s_0 = 0; s_1 = 0;
# output should be the same as v
force {SW[9]} 0
force {SW[8]} 1

run 10ns

# case 3: switch s_0 = 1; s_1 = 0;
# output should be the same as w
force {SW[9]} 1
force {SW[8]} 0

run 10ns

# case 4: switch s_0 = 1; s_1 = 1;
# output should be the same as x
force {SW[9]} 1
force {SW[8]} 1

run 10ns

