vlib work

vlog -timescale 1ns/1ps clkrcounter.v

vsim clkrcounter

log {/*}

add wave {/*}



force {enable} 1

force {clk} 0 0ps, 1 1ps -r 2ps

force {load} 2#0000

force {par_load} 0

force {reset_n} 0 0ps, 1 3ps

force {frequency} 2#01

run 1000000ns