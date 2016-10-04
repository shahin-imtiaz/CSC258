module fulladder(a, b, cin, cout, s);
	input a;
	input b;
	input cin;
	output cout;
	output s;
	
	assign s = cin ^ (a ^ b);
	assign cout = ((a ^ b) & cin) | (~(a ^ b) & b);
endmodule


module ripplecarry(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire c0, c1, c2;
	
	fulladder fa0(
		.a(SW[7]),
		.b(SW[3]),
		.cin(SW[8]),
		.cout(c0),
		.s(LEDR[3])
	);
	
	fulladder fa1(
		.a(SW[6]),
		.b(SW[2]),
		.cin(c0),
		.cout(c1),
		.s(LEDR[2])
	);
	
	fulladder fa2(
		.a(SW[5]),
		.b(SW[1]),
		.cin(c1),
		.cout(c2),
		.s(LEDR[1])
	);
	
	fulladder fa3(
		.a(SW[4]),
		.b(SW[0]),
		.cin(c2),
		.cout(LEDR[9]),
		.s(LEDR[0])
	);
endmodule
