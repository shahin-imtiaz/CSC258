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


module datapath(clk, reset_n, enable, draw, color_in, ld_x, ld_y, ld_color, up, down x_out, y_out, color_out);
	input clk, reset_n, enable, draw;
	input ld_x, ld_y, ld_color;
	input up, down;

	output [8:0] x_out;
	output [7:0] y_out;
	output [2:0] color_out;
	
	reg [8:0] x;
	wire [7:0] y;
	reg [2:0] color;
	
	// could vary according to shape
	wire [1:0] y_count;
	// could vary according to shape
	wire [1:0] x_count;
	// where y starts
	reg [7:0] y_start;
	
	wire y_enable;
	
	// register for x, y_start, color
	always @(posedge clk) begin
		if (!reset_n) begin
			x <= 9'b0;
			y_start <= 8'b0;
			color <= 3'b0;
		end
		else begin
			if (ld_x)
				x <= 9'd10;
			if (ld_y)
				y_start <= 8'd60;
			if (ld_color) begin
				if (!draw) begin
					color <= 3'b000;
				end
				else begin
					color <= 3'b111;
				end
			end
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
	

	y_movement_counter y_move(clk, enable, reset_n, up, down, y);
	
	assign x_out = x + x_count;
	assign y_out = y_start + y + y_count;
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


// y movement counter, count up when up signal, down when down signal
module y_movement_counter(clk, enable, reset_n, up, down, out);
	input clk, enable, reset_n, up, down;
	input in, out;
	output reg [7:0] q;

	always @(posedge clk) begin
		if (rst) begin
			q <= 8'd60;
		end
		else if (enable) begin
			if (up && ~down) begin
				if (q == 8'd0) begin
					q <= q;
				end
				else begin
					q <= q - 1'b1;
				end
			end
			else if (down && ~up) begin
				if (q == 8'd114) begin
					q <= q;
				end
				else begin
					q <= q + 1'b1;
				end
			end
			else begin
				q <= q;
			end
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



module control(clk, reset_n, go, enable, ld_color, write_enable);
	input clk, reset_n, go;
	output enable, ld_color;

	reg [1:0] current_state, next_state;

	localparam 	LOAD = 2'b00,
				LOAD_WAIT = 2'b01;
				DRAW = 2'b10;

	always @(*) begin
		case (current_state)
		LOAD: next_state = go ? LOAD_WAIT : LOAD;
		LOAD_WAIT: next_state = go ? LOAD_WAIT : DRAW;
		DRAW: next_state = DRAW;
	end

	always @(*) begin
		enable = 1'b0;
		ld_color = 1'b0;
		case (current_state)
			DRAW: begin
				enable = 1'b1;
				ld_color = 1'b1;
			end
		endcase
	end

	always @(posedge clk) begin
		if (!reset_n) begin
			current_state <= LOAD;
		end
		else begin
			current_state <= next_state;
		end
	end
endmodule







