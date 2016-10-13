module aluregister(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [9:0] SW; // SW[3:0] = A; SW[9] = reset_n; SW[7:5] = function_input
	input [0:0] KEY; // KEY[0] = clk
	output [7:0] LEDR; // LEDR = ALUout; B = LEDR[3:0] = ALUout[3:0]
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // HEX0 = A; HEX[1:3] = 0; {HEX4, HEX5} = ALUout[7:0]
	
	reg [7:0] ALUout;
	wire w1, w2;
	wire [9:0] w3;
	wire [7:0] wout;
	
	registor r0(
		.d(ALUout[7:0]),
		.clk(KEY[0]),
		.reset_n(SW[9]),
		.q(wout[7:0])
	);
	
	function5 a(
		.a(SW[3:0]),
		.c(w1)
	);
	
	function5 b(
		.a(wout[3:0]),
		.c(w2)
	);
	
	ripplecarry r(
		.SW({SW[3:0], wout[3:0]}),
		.LEDR(w3)
	);
	
	always @(*)
	begin
		case(SW[7:5])
			3'b000: ALUout = {SW[3:0], wout[3:0]};
			3'b001: ALUout = {3'b000, w3[9], w3[3:0]};
			3'b010: ALUout = SW[3:0] + wout[3:0];
			3'b011: ALUout = {SW[3:0] | wout[3:0], SW[3:0] ^ wout[3:0]};
			3'b100: ALUout = {7'b0000000, SW[3] | SW[2] | SW[1] | SW[0] | wout[3] | wout[2] | wout[1] | wout[0]};
			3'b101: ALUout = wout[3:0] << SW[3:0];
			3'b110: ALUout = wout[3:0] >> SW[3:0];
			3'b111: ALUout = SW[3:0] * wout[3:0];
			default: ALUout = 8'b00000000;
		endcase
	end
	
	assign LEDR[7:0] = wout[7:0];
	
	hex_play hex0(
		.SW(SW[3:0]),
		.HEX(HEX0[6:0])
	);
	hex_play hex1(
		.SW(4'b0000),
		.HEX(HEX1[6:0])
	);
	hex_play hex2(
		.SW(4'b0000),
		.HEX(HEX2[6:0])
	);
	hex_play hex3(
		.SW(4'b0000),
		.HEX(HEX3[6:0])
	);
	hex_play hex4(
		.SW(LEDR[7:4]),
		.HEX(HEX4[6:0])
	);
	hex_play hex5(
		.SW(LEDR[3:0]),
		.HEX(HEX5[6:0])
	);
endmodule




// registor
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






// function5
module function5(a, c);
	input [3:0] a;
	output c;
	reg m;
	always @(*)
	begin
		case(a)
			4'b0000: m = 1;
			4'b0001: m = 0;
			4'b0010: m = 0;
			4'b0011: m = 1;
			4'b0100: m = 0;
			4'b0101: m = 1;
			4'b0110: m = 1;
			4'b0111: m = 0;
			4'b1000: m = 0;
			4'b1001: m = 1;
			4'b1010: m = 1;
			4'b1011: m = 0;
			4'b1100: m = 1;
			4'b1101: m = 0;
			4'b1110: m = 0;
			4'b1111: m = 1;
			default: m = 0;
		endcase
	end
	assign c = m;
endmodule






// ripple carry
module ripplecarry(SW, LEDR);
	input [7:0] SW;
	output [9:0] LEDR;
	
	wire c0, c1, c2;
	
	fulladder fa0(
		.a(SW[4]),
		.b(SW[0]),
		.cin(1'b0),
		.cout(c0),
		.s(LEDR[0])
	);
	
	fulladder fa1(
		.a(SW[5]),
		.b(SW[1]),
		.cin(c0),
		.cout(c1),
		.s(LEDR[1])
	);
	
	fulladder fa2(
		.a(SW[6]),
		.b(SW[2]),
		.cin(c1),
		.cout(c2),
		.s(LEDR[2])
	);
	
	fulladder fa3(
		.a(SW[7]),
		.b(SW[3]),
		.cin(c2),
		.cout(LEDR[9]),
		.s(LEDR[3])
	);
endmodule

module fulladder(a, b, cin, cout, s);
	input a;
	input b;
	input cin;
	output cout;
	output s;
	
	assign s = cin ^ (a ^ b);
	assign cout = ((a ^ b) & cin) | (~(a ^ b) & b);
endmodule








// Hex
module hex_play(SW,HEX);
	input [3:0] SW;
	output [6:0] HEX;
	
	zero m1(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[0])
		);
	one m2(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[1])
		);
	two m3(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[2])
		);
	three m4(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[3])
		);
   four m5(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[4])
		);
	five m6(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[5])
		);
	six m7(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[6])
		);
endmodule

module zero(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((b & c) | (~a & d) | (~a & ~c) | (~b & ~c & d) | (a & c & ~d) | (b & ~c & ~d));
endmodule

module one(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((~c & ~a) | (~c & ~d) | (d & a & ~b) | (~d & a & b) | (~d & ~a & ~b));
endmodule

module two(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((c & ~d) | (~c & d) | (a & ~c) | (a & ~b) | (~d & ~a & ~b));
endmodule

module three(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((c & a & ~b) | (c & ~a & b) | (d & ~a & ~b) | (~c & ~a & ~b) | (~c & a & b) | (b & ~c & ~d));
endmodule

module four(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;

   assign m = ~((b & d) | (~a & d) | (~c & ~a) | (c & d & ~b) | (~d & ~a & b));
endmodule

module five(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((b & d) | (~a & d) | (~a & c) | (~a & ~b) | (~b & c & ~d) | (~b & ~c & d));
endmodule

module six(a,b,c,d,m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((d & a) | (d & b) | (~c & b) | (~a & c & ~d) | (~b & c & ~d) | (~b & ~c & d));
endmodule
