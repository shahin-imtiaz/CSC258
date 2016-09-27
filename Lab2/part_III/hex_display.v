module hex_display(SW, HEX);
	input [9:0] SW;
	output [6:0] HEX;
	
endmodule


module zeroth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (a & ~d) | (~b & ~d) | (~a & c) | (a & ~b & ~c) | (~a & b & d) | (b & c & d);
endmodule


module first(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (~b & ~c) | (~a & ~c & ~d) | (a & ~c & d) | (~a & ~b & c) | (~b & c & d);
endmodule


module second(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (~a & ~c) | (~a & ~d) | (~b & ~c) | (~b & ~d) | (a & ~c & d) | (~a & b & c) | (a & ~b & c);
endmodule


module third(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (a & ~c) | (~a & ~b & ~d) | (b & ~c & d) | (~b & c & d) | (b & c & ~d);
endmodule


module fourth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ();
endmodule


module fifth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ();
endmodule


module sixth(a, b, c, d, m);
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = ();
endmodule
