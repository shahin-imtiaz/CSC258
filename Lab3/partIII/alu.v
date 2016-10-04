module alu(SW, KEY, LEDR);
	input [7:0] SW;
	input [2:0] KEY;
	output [7:0] LEDR;
//	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	reg [7:0] ALUout;
	
	wire w1, w2;
//	wire [9:0] w1;

	
	function5 a(
		.a(SW[7:4]),
		.c(w1)
	);
	
	function5 b(
		.a(SW[3:0]),
		.c(w2)
	);
	
	always @(*)
	begin
		case(KEY[2:0])
			3'b000: ALUout = {SW[7:4], SW[3:0]};
//			3'b001: ALUout = {3'b000, w1[9], w1[3:0]};
			3'b010: ALUout = SW[7:4] + SW[3:0];
			3'b011: ALUout = {SW[7:4] | SW[3:0], SW[7:4] ^ SW[3:0]};
			3'b100: ALUout = {7'b0000000, SW[7] | SW[6] | SW[5] | SW[4] | SW[3] | SW[2] | SW[1] | SW[0]};
			3'b101: ALUout = {7'b0000000, w1 & w2};
			default: ALUout = 8'b00000000;
		endcase
	end
	
	assign LEDR = ALUout;
	
//	hex_display hex0(
//		.SW(SW[7:4]),
//		.HEX(HEX0[6:0])
//	);
//	hex_display hex1(
//		.SW(4'b0000),
//		.HEX(HEX1[6:0])
//	);
//	hex_display hex2(
//		.SW(SW[3:0]),
//		.HEX(HEX2[6:0])
//	);
//	hex_display hex3(
//		.SW(4'b0000),
//		.HEX(HEX3[6:0])
//	);
//	hex_display hex4(
//		.SW(ALUout[3:0]),
//		.HEX(HEX4[6:0])
//	);
//	hex_display hex5(
//		.SW(ALUout[4:0]),
//		.HEX(HEX5[6:0])
//	);
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

//// ripple carry
//module fulladder(a, b, cin, cout, s);
//	input a;
//	input b;
//	input cin;
//	output cout;
//	output s;
//	
//	assign s = cin ^ (a ^ b);
//	assign cout = ((a ^ b) & cin) | (~(a ^ b) & b);
//endmodule
//
//
//module ripplecarry(SW, LEDR);
//	input [9:0] SW;
//	output [9:0] LEDR;
//	
//	wire c0, c1, c2;
//	
//	fulladder fa0(
//		.a(SW[7]),
//		.b(SW[3]),
//		.cin(SW[8]),
//		.cout(c0),
//		.s(LEDR[3])
//	);
//	
//	fulladder fa1(
//		.a(SW[6]),
//		.b(SW[2]),
//		.cin(c0),
//		.cout(c1),
//		.s(LEDR[2])
//	);
//	
//	fulladder fa2(
//		.a(SW[5]),
//		.b(SW[1]),
//		.cin(c1),
//		.cout(c2),
//		.s(LEDR[1])
//	);
//	
//	fulladder fa3(
//		.a(SW[4]),
//		.b(SW[0]),
//		.cin(c2),
//		.cout(LEDR[9]),
//		.s(LEDR[0])
//	);
//endmodule



// HEX module
//module hex_display(SW, HEX);
//	input [4:0] SW;
//	output [6:0] HEX;
//	
//	zeroth hex0(
//		.a(SW[0]), // c_0
//		.b(SW[1]), // c_1
//		.c(SW[2]), // c_2
//		.d(SW[3]), // c_3
//		.m(HEX[0])
//	);
//	
//	first hex1(
//		.a(SW[0]),
//		.b(SW[1]),
//		.c(SW[2]),
//		.d(SW[3]),
//		.m(HEX[1])
//	);
//	
//	second hex2(
//		.a(SW[0]),
//		.b(SW[1]),
//		.c(SW[2]),
//		.d(SW[3]),
//		.m(HEX[2])
//	);
//	
//	third hex3(
//		.a(SW[0]),
//		.b(SW[1]),
//		.c(SW[2]),
//		.d(SW[3]),
//		.m(HEX[3])
//	);
//	
//	fourth hex4(
//		.a(SW[0]),
//		.b(SW[1]),
//		.c(SW[2]),
//		.d(SW[3]),
//		.m(HEX[4])
//	);
//	
//	fifth hex5(
//		.a(SW[0]),
//		.b(SW[1]),
//		.c(SW[2]),
//		.d(SW[3]),
//		.m(HEX[5])
//	);
//	
//	sixth hex6(
//		.a(SW[0]),
//		.b(SW[1]),
//		.c(SW[2]),
//		.d(SW[3]),
//		.m(HEX[6])
//	);
//endmodule
//
//
//module zeroth(a, b, c, d, m);
//	input a;
//	input b;
//	input c;
//	input d;
//	output m;
//	
//	//assign m = ~((a & ~d) | (~b & ~d) | (~a & c) | (a & ~b & ~c) | (~a & b & d) | (b & c & d));
//	assign m = (~a & b & ~c & ~d) | (a & b & ~c & d) | (a & ~b & c & d);
//endmodule
//
//
//module first(a, b, c, d, m);
//	input a;
//	input b;
//	input c;
//	input d;
//	output m;
//	
//	// assign m = ~((~b & ~c) | (~b & ~d) | (~a & ~c & ~d) | (a & ~c & d) | (~a & c & d));
//	assign m = (b & c & ~d) | (a & b & ~d) | (a & c & d) | (~a & b & ~c & d); 
//endmodule
//
//
//module second(a, b, c, d, m);
//	input a;
//	input b;
//	input c;
//	input d;
//	output m;
//	
//	//assign m = ~((~a & ~c) | (~a & d) | (~b & ~c) | (~b & d) | (a & ~c & d) | (~a & b & c) | (a & ~b & c));
//	assign m = (a & b & c) | (a & b & ~d) | (~a & ~b & ~c & d) | (~a & ~b & c & ~d);
//endmodule
//
//
//module third(a, b, c, d, m);
//	input a;
//	input b;
//	input c;
//	input d;
//	output m;
//	
//	// assign m = ~((a & ~c) | (~a & ~b & ~d) | (b & ~c & d) | (~b & c & d) | (b & c & ~d));
//	assign m = (b & c & d) | (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (a & ~b & c & ~d);
//endmodule
//
//
//module fourth(a, b, c, d, m);
//	input a;
//	input b;
//	input c;
//	input d;
//	output m;
//	
//	// assign m = ~((a & c) | (a & ~d) | (~a & ~b & ~d) | (~a & c & ~d) | (a & b & d));
//	assign m = (a & d) | (~a & b & ~c) | (~b & ~c & d);
//endmodule
//
//
//module fifth(a, b, c, d, m);
//	input a;
//	input b;
//	input c;
//	input d;
//	output m;
//	
//	// assign m = ~((a & c) | (a & ~d) | (~a & ~c & ~d) | (~a & b & ~d) | (~a & b & c) | (a & ~b & d));
//	assign m = (~a & ~b & c) | (~a & ~b & c) | (a & c & d) | (a & b & ~c & d);
//endmodule
//
//
//module sixth(a, b, c, d, m);
//	input a;
//	input b;
//	input c;
//	input d;
//	output m;
//	
//	// assign m = ~((a & c) | (a & d) | (~b & c) | (~a & b & ~c) | (a & ~b & ~c) | (~a & c & ~d));
//	assign (~a & ~b & ~c) | (~a & b & c & d) | (a & b & ~c & ~d);
//endmodule
