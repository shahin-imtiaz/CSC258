module fulladder(A, B, cin, cout, S);
	input A;
	input B;
	input cin;
	output cout;
	output S;
	
	assign S = cin ^ (a ^ b);
	assign cout = ((a ^ b) & cin) | (~(a ^ b) & b);
endmodule

module ripplecarry(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	
