vlib work

vlog -timescale 1ns/1ns airplane.v

vsim datapath

log {/*}

add wave {/*}

# posedge: 10, 30, 50, 70
force {clk} 0 0, 1 10 -r 20

force {reset_n} 0 0, 1 20

force {x_in} 2#1010101 0

force {y_in} 2#1111000 0

force {ld_x} 0 0, 1 30, 0 40

force {ld_y} 0 0, 1 40, 0 60

force {color_in} 2#101

force {ld_color} 0 0, 1 60, 0 80

force {enable} 0 0, 1 100

run 1000 ns