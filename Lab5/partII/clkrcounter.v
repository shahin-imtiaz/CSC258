module clkrcounter(SW, HEX0, CLOCK_50);
	input CLOCK_50;
	input [9:0] SW; // 1:0: frequency; 2: enable; 3: reset_n; 7:4: load; 9: par_load
	output [6:0] HEX0;
	
	wire [3:0] ctoh;
	
	counter c0(SW[2], SW[7:4], SW[9], CLOCK_50, SW[3], SW[1:0], ctoh);
	
	hex h0(ctoh, HEX0);


endmodule


module counter(enable, load, par_load, clk, reset_n, frequency, out);
	input clk, enable, par_load, reset_n;
	input [1:0] frequency;
	input [3:0] load;
	output [3:0] out;
	
	wire [27:0] w1hz, w05hz, w025hz;
	reg cenable;
	
	ratedivider r1hz(enable, {2'b00, 26'd49999999}, clk, reset_n, w1hz);
	ratedivider r05hz(enable, {1'b0, 27'd99999999}, clk, reset_n, w05hz);
	ratedivider r025hz(enable, {28'd499999999}, clk, reset_n, w025hz);
	
	always @(*)
		begin
			case(frequency)
				2'b00: cenable = enable;
				2'b01: cenable = (w1hz == 0) ? 1 : 0;
				2'b10: cenable = (w05hz == 0) ? 1 : 0;
				2'b11: cenable = (w025hz == 0) ? 1 : 0;
			endcase
		end
		
	displaycounter d(cenable, load, par_load, clk, reset_n, out);

endmodule


module displaycounter(enable, load, par_load, clk, reset_n, q);
	input enable, clk, par_load, reset_n;
	input [3:0] load;
	output reg [3:0] q;
	
	always @(posedge clk, negedge reset_n)
	begin
		if (reset_n == 1'b0)
			q <= 4'b0000;
		else if (par_load == 1'b1)
			q <= load;
		else if (enable == 1'b1)
			begin
				if (q == 4'b1111)
					q <= 4'b0000;
				else
					q <= q + 1'b1;
			end
	end
endmodule


module ratedivider(enable, load, clk, reset_n, q);
	input enable, clk, reset_n;
	input [27:0] load;
	output reg [27:0] q;
	
	always @(posedge clk)
	begin
		if (reset_n == 1'b0)
			q <= load;
		else if (enable == 1'b1)
			begin
				if (q == 0)
					q <= load;
				else
					q <= q - 1'b1;
			end
	end
endmodule


// HEX

module hex(in,out);
	input [3:0] in;
	output [6:0] out;
	
	zero m1(
		.a(in[0]),
		.b(in[1]),
		.c(in[2]),
		.d(in[3]),
		.m(out[0])
		);
	one m2(
		.a(in[0]),
		.b(in[1]),
		.c(in[2]),
		.d(in[3]),
		.m(out[1])
		);
	two m3(
		.a(in[0]),
		.b(in[1]),
		.c(in[2]),
		.d(in[3]),
		.m(out[2])
		);
	three m4(
		.a(in[0]),
		.b(in[1]),
		.c(in[2]),
		.d(in[3]),
		.m(out[3])
		);
   four m5(
		.a(in[0]),
		.b(in[1]),
		.c(in[2]),
		.d(in[3]),
		.m(out[4])
		);
	five m6(
		.a(in[0]),
		.b(in[1]),
		.c(in[2]),
		.d(in[3]),
		.m(out[5])
		);
	six m7(
		.a(in[0]),
		.b(in[1]),
		.c(in[2]),
		.d(in[3]),
		.m(out[6])
		);
endmodule

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

   assign m = ~((b & d) | (~a & d) | (~c & ~a) | (c & d & ~b) | (~d & ~a & b));
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
