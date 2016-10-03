module mux2to1(x, y, s, m);
	input x, y, s;
	output m;
	
	assign m = (~s & x) | (s & y);
endmodule

module mux7to1(SW, LED);
	input SW[9:0]
