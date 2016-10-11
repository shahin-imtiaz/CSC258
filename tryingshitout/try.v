module try(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	shifterbit s(
		.load_val(SW[0]),
		.load_n(SW[6]),
		.clk(SW[8]),
		.reset_n(SW[9]),
		.shift(SW[7]),
		.in(SW[1]),
		.out(LEDR[0])
	);
endmodule

module shifterbit(load_val, load_n, clk, reset_n, shift, in, out);
	input load_val, load_n, clk, reset_n, shift, in;
	output out;
	
	wire w0, w1;
	
	mux m0(
		.x(out),
		.y(in),
		.s(shift),
		.m(w0)
	);
	
	mux m1(
		.x(load_val),
		.y(w0),
		.s(load_n),
		.m(w1)
	);
	
	dff d0(
		.d(w1),
		.clk(clk),
		.r(reset_n),
		.q(out)
	);

endmodule


// dff
module dff(d, clk, r, q);
	input d, clk, r;
	output q;
	
	reg q;
	
	always @(posedge clk)
	begin
		if (r == 1'b0)
			q <= 1'b0;
		else
			q <= d;
	end
endmodule


// mux
module mux(x, y, s, m);
    input x;
    input y;
    input s;
    output m;
  
    assign m = s & y | ~s & x;
endmodule
