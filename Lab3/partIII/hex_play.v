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

   assign m = ~((b & d) | (~a & d) | (~c & ~a) | (c & a & ~b));
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
	
module hex_play(SW,HEX);
	input [9:0] SW;
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


	

