module alu(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [7:0] SW;
	input [2:0] KEY;
	output [7:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
	
	reg [7:0] ALUout;
	
	hex_display hex0(
		.SW(SW[7:4]),
		.HEX(HEX0[6:0])
	);
	hex_display hex1(
		.SW(0000),
		.HEX(HEX1[6:0])
	);
	hex_display hex2(
		.SW(SW[3:0]),
		.HEX(HEX2[6:0])
	);
	hex_display hex3(
		.SW(0000),
		.HEX(HEX3[6:0])
	);
	hex_display hex4(
		.SW(ALUout[3:0]),
		.HEX(HEX4[6:0])
	);
	hex_display hex5(
		.SW(ALUout[4:0]),
		.HEX(HEX5[6:0])
	);
	
	always @(*)
	begin
		case(KEY[2:0])
			3'b000: ALUout = f0;
			3'b001: ALUout = f1;
			3'b010: ALUout = f2;
			3'b011: ALUout = f3;
			3'b100: ALUout = f4;
			3'b101: ALUout = f5;
			default: m = 00000000
		endcase
	end
	
endmodule


// HEX module
module hex_display(SW, HEX);
	input [4:0] SW;
	output [6:0] HEX;
	
	zeroth hex0(
		.a(SW[0]), // c_0
		.b(SW[1]), // c_1
		.c(SW[2]), // c_2
		.d(SW[3]), // c_3
		.m(HEX[0])
	);
	
	first hex1(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[1])
	);
	
	second hex2(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[2])
	);
	
	third hex3(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[3])
	);
	
	fourth hex4(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[4])
	);
	
	fifth hex5(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[5])
	);
	
	sixth hex6(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.m(HEX[6])
	);
endmodule


module zeroth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	//assign m = ~((a & ~d) | (~b & ~d) | (~a & c) | (a & ~b & ~c) | (~a & b & d) | (b & c & d));
	assign m = (~a & b & ~c & ~d) | (a & b & ~c & d) | (a & ~b & c & d);
endmodule


module first(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	// assign m = ~((~b & ~c) | (~b & ~d) | (~a & ~c & ~d) | (a & ~c & d) | (~a & c & d));
	assign m = (b & c & ~d) | (a & b & ~d) | (a & c & d) | (~a & b & ~c & d); 
endmodule


module second(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	//assign m = ~((~a & ~c) | (~a & d) | (~b & ~c) | (~b & d) | (a & ~c & d) | (~a & b & c) | (a & ~b & c));
	assign m = (a & b & c) | (a & b & ~d) | (~a & ~b & ~c & d) | (~a & ~b & c & ~d);
endmodule


module third(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	// assign m = ~((a & ~c) | (~a & ~b & ~d) | (b & ~c & d) | (~b & c & d) | (b & c & ~d));
	assign m = (b & c & d) | (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (a & ~b & c & ~d);
endmodule


module fourth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	// assign m = ~((a & c) | (a & ~d) | (~a & ~b & ~d) | (~a & c & ~d) | (a & b & d));
	assign m = (a & d) | (~a & b & ~c) | (~b & ~c & d);
endmodule


module fifth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	// assign m = ~((a & c) | (a & ~d) | (~a & ~c & ~d) | (~a & b & ~d) | (~a & b & c) | (a & ~b & d));
	assign m = (~a & ~b & c) | (~a & ~b & c) | (a & c & d) | (a & b & ~c & d);
endmodule


module sixth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	// assign m = ~((a & c) | (a & d) | (~b & c) | (~a & b & ~c) | (a & ~b & ~c) | (~a & c & ~d));
	assign (~a & ~b & ~c) | (~a & b & c & d) | (a & b & ~c & ~d);
endmodule
