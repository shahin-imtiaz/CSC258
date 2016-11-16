//module airplane_top (
//		CLOCK50,
//		VGA_CLK,   						//	VGA Clock
//		VGA_HS,							//	VGA H_SYNC
//		VGA_VS,							//	VGA V_SYNC
//		VGA_BLANK_N,						//	VGA BLANK
//		VGA_SYNC_N,						//	VGA SYNC
//		VGA_R,   						//	VGA Red[9:0]
//		VGA_G,	 						//	VGA Green[9:0]
//		VGA_B   						//	VGA Blue[9:0])
//
//		);
//		
//endmodule
//
//
//
//
//
//module airplane(clk, reset_n, enable, up, down);
//	input CLOCK50;
//	input [] KEY;
//	
//	datapath d(clk, reset_n, enable, ld_x, ld_y, ld_color)
//	
//endmodule
//
//


module datapath(clk, reset_n, enable, draw, x_in, y_in, color_in, ld_x, ld_y, ld_color, x_out, y_out, color_out);
	input clk, reset_n, enable, draw;
	input ld_x, ld_y, ld_color;
	input [8:0] x_in;
	input [7:0] y_in;
	input [2:0] color_in;
	output [8:0] x_out;
	output [7:0] y_out;
	output [2:0] color_out;
	
	reg [8:0] x;
	reg [7:0] y;
	reg [2:0] color;
	
	// could vary according to shape
	wire [1:0] y_count;
	// could vary according to shape
	wire [1:0] x_count;
	
	
	wire y_enable;
	
	// register for x, y, color
	always @(posedge clk) begin
		if (!reset_n) begin
			x <= 9'b0;
			y <= 8'b0;
			color <= 3'b0;
		end
		else begin
			if (ld_x)
				x <= x_in;
			if (ld_y)
				y <= y_in;
			if (ld_color)
				color <= color_in;
		end
	end
	
	// x counter for square 4 * 4 plane
	// threshold = 2'b11
	// TODO: change x and y counter to shape
	x_counter cx(clk, enable, reset_n, x_count);
	
	// assign y_enable = 1 when x goes through 1 row
	assign y_enable = (x_count == 2'b11) ? 1 : 0;
	
	// y counter for square 4 * 4 plane
	// TODO: change x and y counter to shape
	y_counter cy(clk, y_enable, reset_n, y_count);
	
	
	assign x_out = x + x_count;
	assign y_out = y + y_count;
	assign color_out = color;
	
endmodule



// xy counter, count to the threshold to change row and shape
module x_counter(clk, enable, reset_n, out);
	input clk, enable, reset_n;
	// could vary according to shape
	output reg [1:0] out;
	
	always @(posedge clk) begin
		if (!reset_n)
			out <= 2'b0;
		else if (enable) begin
			if (out == 2'b11)
				out <= 2'b0;
			else
				out <= out + 1'b1;
		end
	end
endmodule



// y counter, count to the threshold to change column and shape
module y_counter(clk, enable, reset_n, out);
	input clk, enable, reset_n;
	// could vary according to shape
	output reg [1:0] out;
	
	always @(posedge clk) begin
		if (!reset_n)
			out <= 2'b0;
		else if (enable) begin
			if (out == 2'b11)
				out <= 2'b0;
			else
				out <= out + 1'b1;
		end
	end
endmodule



// frame counter, count to 15 for every move so that the frame could refresh
module frame_counter(clk, enable, reset_n, out);
	input clk, enable, reset_n;
	output reg [3:0] out;
	
	always @(posedge clk) begin
		if (!reset_n)
			out <= 4'b0;
		else if (enable) begin
			if (out == 4'b1111)
				out <= 4'b0;
			else
				out <= out + 1'b1;
		end
	end
endmodule











