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

module counter_1(clock,reset_n,enable,q);
	input clock,reset_n,enable;
	output reg [3:0] q;
	
	always @(posedge clock)
	begin
		if(reset_n == 1'b0)
			q <= 4'd00;
		else if(enable == 1'b1)
		begin
		  if(q == 4'd15)
			  q <= 4'd0;
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
				 q <= q + 1'b1;
		   end
			else if((signal_1 == 0) & (signal_2 == 1))
			begin
			   if(q == 8'd119)
				 q <= q;
				else
				 q <= q - 1'b1;
			end
			else if((signal_1 == 1) & (signal_2 == 1))
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

module datapath(enable,signal_1,signal_2,clock,ld_c,colour,reset_n,X,Y,colour_out);
	input enable,clock,reset_n,ld_c;
	input signal_1,signal_2;
	input [2:0] colour;
	output[7:0] X,Y;
	output[2:0] colour_out;
	
	wire[3:0] c1;
	wire[7:0] y_in;
	wire[2:0] colour_1;
	
	
   counter_1 m1(clock,reset_n,enable,c1);
	assign enable_1 = (c1==  4'd15) ? 1 : 0;
	y_counter m2(enable_1,reset_n,enable,signal_1,signal_2,y_in);
	assign colour_1 = (c1==  4'd15) ? 3'b000 : colour;
	datapath1 m3(8'd10,y_in,colour_1,ld_c,clock,reset_n,enable,X,Y,colour_out);
endmodule

module control(clock,reset_n,go_up,go_down,enable,ld_c,signal);
	input clock,reset_n,go_up,go_down;
	output reg enable,ld_c,signal;	
	
	reg [3:0] current_state, next_state;
	
	localparam  S_LOAD_SIGNAL       = 4'd0,
                S_LOAD_SIGNAL_WAIT   = 4'd1,
					 S_MOVE_UP = 4'd2,
					 S_MOVE_DOWN = 4'd3;
	
	always@(*)
      begin: state_table 
            case (current_state)
                S_LOAD_SIGNAL: next_state = (go_up | go_down) ? S_LOAD_SIGNAL_WAIT : S_LOAD_SIGNAL; 
                S_LOAD_SIGNAL_WAIT: next_state = go_up ? S_MOVE_DOWN : S_MOVE_UP;  
                S_MOVE_UP: next_state = S_LOAD_SIGNAL; 
            default:     next_state = S_LOAD_SIGNAL;
        endcase
      end 
   
	always@(*)
      begin: enable_signals
        // By default make all our signals 0
        ld_c = 1'b0;
		  enable = 1'b0;
		  signal = 1'b0;
		  
		  case(current_state)
				S_MOVE_UP:begin
				   ld_c = 1'b1;
					enable = 1'b1;
					signal = 1'b1;
					end
		      S_MOVE_DOWN:begin
					ld_c = 1'b1;
					enable = 1'b1;
					signal = 1'b0;
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


	
	
	
	





	
	
	
	
	
	
	
	
	
	