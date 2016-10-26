module morseencoder(SW, KEY, LEDR, CLOCK_50);
	input [2:0] SW;
	input CLOCK_50;
	input [1:0] KEY;
	output [0:0] LEDR;
	
	morse m0(SW[2:0], KEY[1], CLOCK_50, KEY[0], LEDR[0], 1'b1);

endmodule



module morse(key, start, clk, asr_n, out, rate);
	input [2:0] key;
	input start, asr_n, rate, clk;
	output out;
	
	wire [13:0] letter;
	wire [24:0] rdval;
	wire shift_enable;
	wire [24:0] countdown;
	
	reg rdenable, par_load;
	
	always @(negedge start, negedge asr_n)
	begin
		if (asr_n == 0)
			begin
			par_load <= 1;
			rdenable <= 0;
			end
		else if (start == 0)
			begin
			par_load <= 0;
			rdenable <= 1'b1;
			end
	end
	
	
	assign countdown = (rate == 1) ? 25'd24999999 : 25'd3;
	
	lut lut0(key, letter);
	
	ratedivider rd0(rdenable, countdown, clk, asr_n, rdval);
	
	assign shift_enable = (rdval == 0) ? 1 : 0;
	
	shifter s0(shift_enable, letter, par_load, asr_n, clk, out);

endmodule


module shifter(enable, load, par_load, asr_n, clk, out);
	input enable, par_load, asr_n, clk;
	input [13:0] load;
	output reg out;
	
	reg [13:0] q;
	
	always @(posedge clk, negedge asr_n)
	begin
		if (asr_n == 0)
			begin
			out <= 0;
			q <= 14'b0;
			end
		else if (par_load == 1)
			begin
			out <= 0;
			q <= load;
			end
		else if (enable == 1)
			begin
			out <= q[0];
			q <= q >> 1'b1;
			end
	end

endmodule



module lut(key, out);
	input [2:0] key;
	output reg [13:0] out;
	
	always @(*)
	begin
		case(key)
			3'd0: out = {8'd0, 6'b010101};
			3'd1: out = {10'd0, 4'b0111};
			3'd2: out = {6'd0, 8'b01110101};
			3'd3: out = {4'd0, 10'b0111010101};
			3'd4: out = {4'd0, 10'b0111011101};
			3'd5: out = {2'd0, 12'b011101010111};
			3'd6: out = {14'b01110111010111};
			3'd7: out = {2'd0, 12'b010101110111};
		endcase
	end

endmodule


module ratedivider(enable, load, clk, asr_n, q);
	input enable, clk, asr_n;
	input [24:0] load;
	output reg [24:0] q;
	
	always @(posedge clk, negedge asr_n)
	begin
		if (asr_n == 1'b0)
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
