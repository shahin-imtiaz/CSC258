vlib work

vlog -timescale 1ps/1ps ram32x4.v

vsim -L altera_mf_ver ram32x4

log {/*}

add wave {/*}

force {address} 2#01101 0, 2#01000 55, 2#10010 115 

force {clock} 0 0, 1 10 -r 20

force {data} 2#1010 0, 2#1111 35, 2#0000 55, 2#1001 115

force {wren} 0 0, 1 10 -r 20 


run 200ps