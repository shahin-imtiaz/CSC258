module hex_display(SW, HEX);
	input [9:0] SW;
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
	
	assign m = ~((a & ~d) | (~b & ~d) | (~a & c) | (a & ~b & ~c) | (~a & b & d) | (b & c & d));
endmodule


module first(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((~b & ~c) | (~b & ~d) | (~a & ~c & ~d) | (a & ~c & d) | (~a & c & d));
endmodule


module second(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((~a & ~c) | (~a & d) | (~b & ~c) | (~b & d) | (a & ~c & d) | (~a & b & c) | (a & ~b & c));
endmodule


module third(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((a & ~c) | (~a & ~b & ~d) | (b & ~c & d) | (~b & c & d) | (b & c & ~d));
endmodule


module fourth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((a & c) | (a & ~d) | (~a & ~b & ~d) | (~a & c & ~d) | (a & b & d));
endmodule


module fifth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((a & c) | (a & ~d) | (~a & ~c & ~d) | (~a & b & ~d) | (~a & b & c) | (a & ~b & d));
endmodule


module sixth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ~((a & c) | (a & d) | (~b & c) | (~a & b & ~c) | (a & ~b & ~c) | (~a & c & ~d));
endmodule
