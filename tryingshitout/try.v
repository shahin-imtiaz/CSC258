module try(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	registor r0(
		.d(SW[7:0]),
		.clk(SW[9]),
		.reset_n(SW[8]),
		.q(LEDR[7:0])
	);
endmodule

module registor(d, clk, reset_n, q);
	input [7:0] d;
	input clk, reset_n;
	output [7:0] q;
	reg [7:0] q;
	always @(posedge clk)
	begin
		if (reset_n == 1'b0)
			q <= 8'b00000000;
		else
			q <= d;
	end
endmodule
