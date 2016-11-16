// Part 2 skeleton

module part2
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;  // SW[9:7] color(r,g,b), SW[6:0] input(x,y) note: 128*128 since x has 7 bits not 8, set msb to 0
	input   [3:0]   KEY; // KEY[0] resetn, KEY[1] draw, KEY[3] load

	// Declare your inputs and outputs here
	
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	wire ldx, ldy, ldc, enable;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.
    
	ratedivider r0(	.enable(enable),
					.load(28'd24999999),
					.clk(CLOCK_50),
					.reset_n(resetn),
					.q()); 
	 
    // Instansiate datapath
	datapath d0(	.clk(CLOCK_50),
					.enable(enable),
	 
					.ld_x(ldx),
					.ld_y(ldy),
					.ld_color(ldc),
					.reset_n(resetn),
					.color_in(SW[9:7]),
					.coord(SW[6:0]),
					.x_out(x),
					.y_out(y),
					.color_out(colour));

    // Instansiate FSM control
	control c0(	.clk(CLOCK_50),
				.reset_n(resetn),
				.ld(KEY[3]),
				.start(KEY[1]),
				.ld_x(ldx),
				.ld_y(ldy),
				.ld_color(ldc),
				.writeEn(writeEn),
				.enable(enable));
    
endmodule



module datapath
	(
		input clk,
		input ld_x, ld_y, ld_color,
		input reset_n, enable,
		input [2:0] color_in,
		input [6:0] coord,
		output [7:0] x_out,
		output [6:0] y_out,
		output [2:0] color_out
	);
	
	reg [2:0] count_x, count_y;
	reg [7:0] x;
	reg [6:0] y;
	reg [2:0] color;
	wire y_enable;
	wire [1:0] rate_count_down;
	
	
	// registors for x, y and color
	always @(posedge clk) begin
		if (!reset_n) begin
			x <= 8'b0;
			y <= 7'b0;
			color <= 3'b0;
		end
		else begin
			if (ld_x)
				x <= {1'b0, coord};
			if (ld_y)
				y <= coord;
			if (ld_color)
				color <= color_in;
		end
	end
	
	
//	// counter for x
//	always @(posedge clk) begin
//		if (!reset_n)
//			count_x <= 2'b00;
//		else if (enable) begin
//			if (count_x == 2'b11)
//				count_x <= 2'b00;
//			else
//				count_x <= count_x + 1'b1;
//		end
//	end
//		
//	rate_divider rd_y(clk, 1'b0, enable, reset_n, rate_count_down);
//	assign y_enable = (rate_count_down == 2'b00) ? 1 : 0;
//	
//	// counter for y
//	always @(posedge clk) begin
//		if (!reset_n)
//			count_y <= 2'b00;
//		else if (enable && y_enable) begin
//			if (count_y != 2'b00)
//				count_y <= count_y + 2'b01;
//		end
//	end
	

	// counter for x
	always @(posedge clk) begin
		if (!reset_n)
			count_x <= 2'b00;
		else if (enable) begin
			if (count_x == 2'b11)
				count_x <= 2'b00;
			else begin
				count_x <= count_x + 1'b1;
			end
		end
	end
	
	assign y_enable = (count_x == 2'b11) ? 1 : 0;
	
	// counter for y
	always @(posedge clk) begin
		if (!reset_n)
			count_y <= 2'b00;
		else if (enable && y_enable) begin
			if (count_y != 2'b11)
				count_y <= count_y + 1'b1;
			else 
				count_y <= 2'b00;
		end
	end
	
	assign x_out = x + count_x;
	assign y_out = y + count_y;
	assign color_out = color;
	
endmodule

module rate_divider(input clk, rate, rdenable_in, reset_n, output reg [1:0] q);
	reg [1:0] delay_count;
	
	always @(*) begin
		case (rate)
			1'b0: delay_count = 2'b11;
//			1'b1: delay_count = 4'b1111;
			default: delay_count = 2'b00;
		endcase
	end
	
	always @(posedge clk) begin
		if (!reset_n)
			q <= delay_count;
		else if (rdenable_in) begin
			if (q == 2'b00)
				q <= delay_count;
			else
				q <= q - 1'b1;
		end
	end
endmodule



module control
	(
		input clk, reset_n, ld, start,
<<<<<<< HEAD
=======
		
>>>>>>> f9dc0eafa60e0bb36bd92c3fb435d51506f5b18b
		output reg ld_x, ld_y, ld_color, writeEn, enable
	);
	
	reg [2:0] current_state, next_state;
	
	// States renaming
	localparam 	Load_x = 3'd0,
				Load_x_wait = 3'd1,
				Load_y_color = 3'd2,
				Load_y_color_wait = 3'd3,
				Draw = 3'd4;
					
	// State Table
	always @(*) begin
		case (current_state)
			Load_x: next_state = ld ? Load_x_wait : Load_x;
			Load_x_wait: next_state = ld ? Load_x_wait : Load_y_color;
			Load_y_color: next_state = start ? Load_y_color : Load_y_color;
			Load_y_color_wait: next_state = start ? Load_y_color_wait : Draw;
			Draw: next_state = ld ? Load_x : Draw;
		endcase
	end
	
	// Output Logic
	always @(*) begin
		ld_x = 1'b0;
		ld_y = 1'b0;
		ld_color = 1'b0;
		writeEn = 1'b0;
		
		case (current_state)
			Load_x: 
				ld_x = 1;
				enable = 1;
			Load_x_wait: 
				ld_x = 1;
				enable = 1;
			Load_y_color: begin
				ld_y = 1; ld_color = 1;
				enable = 1;
			end
			Load_y_color_wait: begin
				ld_y = 1; ld_color = 1;
				enable = 1;
			end
			Draw: begin
				writeEn = 1; enable = 1;
			end
		endcase
	end
	
	// Current State Register
	always @(posedge clk) begin
		if (!reset_n)
			current_state <= Load_x;
		else
			current_state <= next_state;
	end

endmodule


// test combined

module combined
	(
		input clk, reset_n, ld, start,
		input [2:0] color_in,
		input [6:0] coord,
		output [7:0] x_out,
		output [6:0] y_out,
		output [2:0] color_out
	);
	
	wire ld_x, ld_y, ld_color, writeEn, enable;
	
	control c0(clk, reset_n, ld, start, ld_x, ld_y, ld_color, writeEn, enable);
	
	datapath d0(clk, ld_x, ld_y, ld_color, reset_n, enable, color_in, coord, x_out, y_out, color_out);
	

endmodule
