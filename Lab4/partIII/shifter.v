module shifter(SW, KEY, LEDR);
	input [9:0] SW; // SW[7:0] = LoadVal[7:0]; SW[9] = reset_n
	input [3:0] KEY; // KEY[0] = clk; KEY[1] = Load_n; KEY[2] = ShiftRight; KEY[3] = ASR
	output [7:0] LEDR; // LEDR = q
	
	shifter8bit s(
		.LoadVal(SW[7:0]),
		.clk(KEY[0]),
		.Load_n(KEY[1]),
		.ShiftRight(KEY[2]),
		.ASR(KEY[3]),
		.reset_n(SW[9]),
		.q(LEDR[7:0])
	);
endmodule



module shifter8bit(LoadVal, Load_n, ShiftRight, ASR, clk, reset_n, q);
	input [7:0] LoadVal;
	input Load_n, ShiftRight, ASR, clk, reset_n;
	output [7:0] q;
	
	wire w0;
	
	asrcircuit asr7(
		.asr(ASR),
		.first(LoadVal[7]),
		.m(w0)
	);
	
	shifterbit s7(
		.load_val(LoadVal[7]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		// Leftmost input?
		.in(w0),
		.out(q[7])
	);
	
	shifterbit s6(
		.load_val(LoadVal[6]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[7]),
		.out(q[6])
	);
	
	shifterbit s5(
		.load_val(LoadVal[5]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[6]),
		.out(q[5])
	);
	
	shifterbit s4(
		.load_val(LoadVal[4]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[5]),
		.out(q[4])
	);
	
	shifterbit s3(
		.load_val(LoadVal[3]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[4]),
		.out(q[3])
	);
	
	shifterbit s2(
		.load_val(LoadVal[2]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[3]),
		.out(q[2])
	);
	
	shifterbit s1(
		.load_val(LoadVal[1]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[2]),
		.out(q[1])
	);
	
	shifterbit s0(
		.load_val(LoadVal[0]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[1]),
		.out(q[0])
	);

endmodule


// asrcircuit
module asrcircuit(asr, first, m);
	input asr, first;
	output reg m;
	always @(*)
	begin
		if (asr == 1'b1)
			m <= first;
		else
			m <= 1'b0;
	end
endmodule


// shifterbit
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
	
	dfflop d0(
		.d(w1),
		.clk(clk),
		.r(reset_n),
		.q(out)
	);

endmodule


// dff
module dfflop(d, clk, r, q);
	input d, clk;
	input r;
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
