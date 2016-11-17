module airplane
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
	input   [9:0]   SW;
	input   [3:0]   KEY;

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
	wire [7:0] y;
	wire writeEn;
	wire enable,ld_c;

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
    
    // Instansiate datapath
	// datapath d0(...);
      datapath d0(enable,KEY[3],KEY[2],CLOCK_50,ld_c,KEY[0],x,y,colour);

    // Instansiate FSM control
    // control c0(...);
	   control c0(CLOCK_50,KEY[0],~KEY[1],enable,ld_c,writeEn);

    
endmodule



module counter(clock,reset_n,enable,q);
	input clock,reset_n,enable;
	output reg [1:0] q;
	
	always @(posedge clock)
	begin
		if(reset_n == 1'b0)
			q <= 2'b00;
		else if(enable == 1'b1)
		begin
		  if(q == 2'b11)
			  q <= 2'b00;
		  else
			  q <= q + 1'b1;
		end
   end
endmodule

module rate_counter(clock,reset_n,enable,q);
		input clock;
		input reset_n;
		input enable;
		output reg [1:0] q;
		
		always @(posedge clock)
		begin
			if(reset_n == 1'b0)
				q <= 2'b11;
			else if(enable ==1'b1)
			begin
			   if ( q == 2'b00 )
					q <= 2'b11;
				else
					q <= q - 1'b1;
			end
		end
endmodule	




module delay_counter(clock,reset_n,enable,q);
		input clock;
		input reset_n;
		input enable;
		output reg [19:0] q;
		
		always @(posedge clock)
		begin
			if(reset_n == 1'b0)
				q <= 20'd0;
			else if(enable ==1'b1)
			begin
			   if ( q == 20'd0 )
					q <= 20'd1666666;
				else
					q <= q - 1'b1;
			end
		end
endmodule


module frame_counter(clock,reset_n,enable,q);
	input clock,reset_n,enable;
	output reg [3:0] q;
	
	always @(posedge clock)
	begin
		if(reset_n == 1'b0)
			q <= 4'b0000;
		else if(enable == 1'b1)
		begin
		  if(q == 4'b1010)
			  q <= 4'b0000;
		  else
			  q <= q + 1'b1;
		end
   end
endmodule




module y_counter(clock,reset_n,enable,signal_1,signal_2,q);
	input clock,enable,reset_n;
	input signal_1,signal_2;
	output reg[7:0] q;
	
	always@(negedge clock)
	begin
		if(reset_n == 1'b0)
			q <= 8'd60;
		else if(enable == 1'b1)
		begin
			if((signal_1 == 1) & (signal_2 == 0))
			begin
				if(q == 8'd0)
			    q <= q ;
			   else
				 q <= q - 1'b1;
		   end
			else if((signal_1 == 0) & (signal_2 == 1))
			begin
			   if(q == 8'd110)
				 q <= q;
				else
				 q <= q + 1'b1;
			end
			else if((signal_1 == 1) & (signal_2 == 1))
			    q <= q;
			else if((signal_1 == 0) & (signal_2 == 0))
			    q <= q;
			
	end		
	end

endmodule





module datapath1(x,y,colour,ld_c,clock,reset_n,enable,X,Y,Colour);
	input reset_n,enable,clock,ld_c;
	input [7:0] x,y;
	input [2:0] colour;
	output[7:0] X;
	output [7:0] Y;
	output [2:0] Colour;
	reg [7:0] x1,y1,co1;
	
	wire [1:0] c1,c2,c3;
	
	always @ (posedge clock) begin
        if (!reset_n) begin
            x1 <= 7'b0; 
            y1 <= 7'b0;
				co1 <= 3'b0;
        end
        else begin
                x1 <= x ;
                y1 <= y;
					 if(ld_c == 1)
					 co1 <= colour;
        end
    end
	counter m1(clock,reset_n,enable,c1);
	rate_counter m2(clock,reset_n,enable,c2);
	assign enable_1 = (c2==  2'b00) ? 1 : 0;
	counter m3(clock,reset_n,enable_1,c3);
	assign X = x1 + c1;
	assign Y = y1 + c3;
	assign Colour = co1;
endmodule

module datapath(enable,signal_1,signal_2,clock,ld_c,reset_n,X,Y,colour_out);
	input enable,clock,reset_n,ld_c;
	input signal_1,signal_2;
	output[7:0] X,Y;
	output[2:0] colour_out;
	
	wire[19:0] c0;
	wire[3:0] c1;
	wire[7:0] y_in;
	wire[2:0] colour_1;
	
	delay_counter m1(clock,reset_n,enable,c0);
	assign enable_1 = (c0 ==  20'd0) ? 1 : 0;
	frame_counter m2(clock,reset_n,enable_1,c1);
	assign enable_2 = (c1 == 4'b1010) ? 1 : 0;
	y_counter m4(enable_2,reset_n,enable,signal_1,signal_2,y_in);
	assign colour_1 = (c1 == 4'b1010) ? 3'b000 : 3'b101;
	datapath1 m7(8'd10,y_in,colour_1,ld_c,clock,reset_n,enable,X,Y,colour_out);
endmodule

module control(clock,reset_n,go,enable,ld_c,plot);
	input clock,reset_n,go;
	output reg enable,ld_c,plot;	
	
	reg [3:0] current_state, next_state;
	
	localparam  S_LOAD_SIGNAL       = 4'd0,
                S_LOAD_SIGNAL_WAIT   = 4'd1,
					 S_MOVE = 4'd2;
	
	always@(*)
      begin: state_table 
            case (current_state)
                S_LOAD_SIGNAL: next_state = go ? S_LOAD_SIGNAL_WAIT : S_LOAD_SIGNAL; 
                S_LOAD_SIGNAL_WAIT: next_state = go ? S_MOVE : S_LOAD_SIGNAL_WAIT;  
                S_MOVE: next_state = S_MOVE; 
            default:     next_state = S_LOAD_SIGNAL;
        endcase
      end 
   
	always@(*)
      begin: enable_signals
        // By default make all our signals 0
        ld_c = 1'b0;
		  enable = 1'b0;
		  plot = 1'b0;
		  
		  case(current_state)
				S_MOVE:begin
				   ld_c = 1'b1;
					enable = 1'b1;
					plot = 1'b1;
					end
		  endcase
    end
	 
	 always@(posedge clock)
      begin: state_FFs
        if(!reset_n)
            current_state <= S_LOAD_SIGNAL;
        else
            current_state <= next_state;
      end 
endmodule


	
	
	
	





	
	
	
	
	
	
	
	
	
	