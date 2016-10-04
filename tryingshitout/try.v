module try(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	assign LEDR = SW[9:5] + SW[4:0];


endmodule
