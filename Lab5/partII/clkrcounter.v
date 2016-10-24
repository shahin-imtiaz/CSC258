module clkcounter(enable, load, par_load, clk, reset_n, frequency, out);
	input clk, enable, par_load, reset_n;
	input [1:0] frequency;
	input [3:0] load;
	output [3:0] out;
	
	wire [27:0] w1hz, w05hz, w025hz;
	wire cenable;
	
	ratedivider r1hz(enable, {2'b00, 8'd49999999}, clk, w1hz);
	ratedivider r05hz(enable, {1'b0, 8'd99999999}, clk, w05hz);
	ratedivider r025hz(enable, 9'b499999999, clk, w025hz);
	
	always @(*)
		begin
			case(frequency)
				2'b00: cenable = 1;
				2'b01: cenable = (w1hz == 0) ? 1 : 0;
				2'b10: cenable = (w05hz == 0) ? 1 : 0;
				2'b11: cenable = (w025hz == 0) ? 1 : 0;
			endcase
		end
		
		
	displaycounter(cenable, load, par_load, clk, reset_n, out);

endmodule

module displaycounter(enable, load, par_load, clk, reset_n, q);
	input enable, clk, par_load, reset_n;
	input [3:0] load;
	output [3:0] q;
	
	always @(posedge clk)
	begin
		if (reset_n == 1'b0)
			q <= 0;
		else if (par_load == 1'b1)
			q <= load;
		else if (enable == 1'b1)
			begin
				if (q == 4'b1111)
					q <= 0;
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
