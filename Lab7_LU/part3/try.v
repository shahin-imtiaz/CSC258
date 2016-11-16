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
		output reg [3:0] q;
		
		always @(posedge clock)
		begin
			if(reset_n == 1'b0)
				q <= 4'b1111;
			else if(enable ==1'b1)
			begin
			   if ( q == 4'b0000 )
					q <= 4'b1111;
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
		  if(q == 4'b1111)
			  q <= 4'b0000;
		  else
			  q <= q + 1'b1;
		end
   end
endmodule

module frame_counter1(clock,reset_n,enable,q);
	input clock,reset_n,enable;
	output reg [4:0] q;
	
	always @(posedge clock)
	begin
		if(reset_n == 1'b0)
			q <= 5'b00000;
		else if(enable == 1'b1)
		begin
		  if(q == 5'b11111)
			  q <= 5'b00000;
		  else
			  q <= q + 1'b1;
		end
   end
endmodule

module x_counter(clock,clock_1,reset_n,enable,signal,q);
	input clock,enable,reset_n,signal,clock_1;
	output reg[7:0] q;
	
//	always@(posedge clock)
//	begin
//		if(reset_n == 1'b0)
//			q <= 8'b00000000;
//	else if(enable == 1'b1)
//		begin
//			if(signal == 1'b1)
//				q <= q + 1'b1;
//			else
//				q <= q - 1'b1;
//		end
//	end
//

	always@(posedge clock)
	begin
		if(reset_n == 1'b0)
			q <= 8'b00000000;
	end
	always@(negedge clock_1)
	   if(reset_n == 1'b1)
			begin
			if(signal == 1'b1)
				q <= q + 1'b1;
			else
				q <= q - 1'b1;
		end
endmodule

module y_counter(clock,clock_1,reset_n,enable,signal,q);
	input clock,enable,signal,reset_n,clock_1;
	output reg[7:0] q;
	
//	always@(posedge clock)
//	begin
//		if(reset_n == 1'b0)
//			q <= 8'b00111100;
//		else if(enable == 1'b1)
//		begin
//			if(signal == 1'b1)
//			q <= q + 1'b1;
//			else
//				q <= q - 1'b1;
//		end
//	end
//endmodule
   always@(posedge clock)
	begin
		if(reset_n == 1'b0)
			q <= 8'b00111100;
	end
	always@(negedge clock_1)
	   if(reset_n == 1'b1)
			begin
			if(signal == 1'b1)
				q <= q + 1'b1;
			else
				q <= q - 1'b1;
		end
endmodule


module v_register(clock,reset_n,y,direction);
	input clock,reset_n;
	input [7:0] y;
	output reg direction;
	
	always@(posedge clock)
	begin
		if(reset_n == 1'b0)
			direction <= 1'b1;
		else
		begin
			if(direction == 1'b1)
			begin
				if(y + 1 > 8'b01110111)
					direction <= 1'b0;
				else
					direction <= 1'b1;
			   end
			else
			begin
				if(y == 8'b00000000)
					direction <= 1'b1;
				else
					direction <= 1'b0;
			end
		end
		end
endmodule

module h_register(clock,reset_n,x,direction);
	input clock,reset_n;
	input [7:0] x;
	output reg direction;
	
	always@(posedge clock)
	begin
		if(reset_n == 1'b0)
			direction <= 1'b1;
		else
		begin
			if(direction == 1'b1)
			begin
				if(x + 1 > 8'b10011111)
					direction <= 1'b0;
				else
					direction <= 1'b1;
			   end
			else
			begin
				if(x == 8'b00000000)
					direction <= 1'b1;
				else
					direction <= 1'b0;
			end
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

module datapath(enable,clock,ld_c,colour,reset_n,X,Y,colour_out);
	input enable,clock,reset_n,ld_c;
	input [2:0] colour;
	output[7:0] X,Y;
	output[2:0] colour_out;
	
	wire[3:0] c0;
	wire[3:0] c1;
	wire signal_x,signal_y;
	wire[7:0] x_in,y_in;
	wire[2:0] colour_1;
	
	delay_counter m1(clock,reset_n,enable,c0);
	assign enable_1 = (c0 ==  4'b0000) ? 1 : 0;
	frame_counter m2(clock,reset_n,enable_1,c1);
	assign enable_2 = (c1 == 4'b1111) ? 1 : 0;
	x_counter m3(clock,enable_2,reset_n,enable_2,signal_x,x_in);
	y_counter m4(clock,enable_2,reset_n,enable_2,signal_y,y_in);
	v_register m5(clock,reset_n,y_in,signal_y);
	h_register m6(clock,reset_n,x_in,signal_x);
	assign colour_1 = (c1 == 4'b1111) ? 3'b000 : colour;
	datapath1 m7(x_in,y_in,colour_1,ld_c,clock,reset_n,enable,X,Y,colour_out);
endmodule

module control(clock,reset_n,go,enable,ld_c,plot);
	input clock,reset_n,go;
	output reg enable,ld_c,plot;	
	
	reg [3:0] current_state, next_state;
	
	localparam  S_LOAD_C       = 4'd0,
                S_LOAD_C_WAIT   = 4'd1,
					 S_CYCLE_0        = 4'd2;
	
	always@(*)
      begin: state_table 
            case (current_state)
                S_LOAD_C: next_state = go ? S_LOAD_C_WAIT : S_LOAD_C; 
                S_LOAD_C_WAIT: next_state = go ? S_LOAD_C_WAIT : S_CYCLE_0;  
                S_CYCLE_0: next_state = S_CYCLE_0;
            default:     next_state = S_LOAD_C;
        endcase
      end 
   
	always@(*)
      begin: enable_signals
        // By default make all our signals 0
        ld_c = 1'b0;
		  enable = 1'b0;
		  plot = 1'b0;
		  
		  case(current_state)
				S_LOAD_C:begin
					end
				S_CYCLE_0:begin
				   ld_c = 1'b1;
					enable = 1'b1;
					plot = 1'b1;
					end
		  endcase
    end
	 
	 always@(posedge clock)
      begin: state_FFs
        if(!reset_n)
            current_state <= S_LOAD_C;
        else
            current_state <= next_state;
      end 
endmodule

module try(clock,reset_n,go,colour,X,Y,Colour);
	input clock,reset_n,go;
	input [2:0] colour;
	output [7:0] X,Y;
	output [2:0] Colour;
	
	wire ld_c,enable,plot;
	
	control m1(clock,reset_n,go,enable,ld_c,plot);
	datapath m2(enable,clock,ld_c,colour,reset_n,X,Y,Colour);

endmodule
	
	
	
	
	





	
	
	
	
	
	
	
	
	
	