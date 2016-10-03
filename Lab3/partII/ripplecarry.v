module fulladder(a, b, cin, cout, s);
	input a;
	input b;
	input cin;
	output cout;
	output s;
	reg cout
	
	assign s = cin ^ a;
	always @(*)
	begin
		case[a ^ b]
			1'b0: cout = b;
			1'b1: cout = cin;
		endcase
	end
endmodule


module ripplecarry(SW, LEDR);
	input [9:0] SW;
	output [4:0] LEDR;
	
	wire c0, c1, c2, c3, c4, c5;
	
	fulladder fa0(
		.a(SW[1]),
		.b(SW[5]),
		.cin(SW[0]),
		.cout(c0),
		.s(LEDR[0])
	);
	
	fulladder fa1(
		.a(SW[2]),
		.b(SW[5]),
		.cin(c0),
		.cout(c1),
		.s(LEDR[1])
	);
	
	fulladder fa2(
		.a(SW[3]),
		.b(SW[6]),
		.cin(c1),
		.cout(c2),
		.s(LEDR[2])
	);
endmodule
