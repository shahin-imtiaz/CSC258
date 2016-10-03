module mux2to1(x, y, s, m);
	input x, y, s;
	output m;
	
	assign m = (~s & x) | (s & y);
endmodule

module mux7to1(SW, LEDR);
	input [9:0] SW;
	output [1:0]LEDR;
	
	wire connector_0;
	wire connector_1;
	wire connector_2;
	wire connector_3;
	wire connector_4;
	
	mux2to1 m0(
		.x(SW[0]),
		.y(SW[1]),
		.s(SW[7]),
		.m(connector_0)
	);
	
	mux2to1 m1(
		.x(SW[2]),
		.y(SW[3]),
		.s(SW[7]),
		.m(connector_1)
	);
	
	mux2to1 m2(
		.x(SW[4]),
		.y(SW[5]),
		.s(SW[7]),
		.m(connector_2)
	);
	
	mux2to1 m3(
		.x(connector_0),
		.y(connector_1),
		.s(SW[8]),
		.m(connector_3)
	);
	
	mux2to1 m4(
		.x(SW[6]),
		.y(connector_2),
		.s(SW[8]),
		.m(connector_4)
	);
	
	mux2to1 m5(
		.x(connector_3),
		.y(connector_4),
		.s(SW[9]),
		.m(LEDR[0])
	);
endmodule
