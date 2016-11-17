module dff_0(clock,reset_n,data_in,q);
		input clock,reset_n,data_in;
		output reg q;
		always@(posedge clock)
		   begin
			if(reset_n == 0) 
				  q <= 1'b0; 
			else
				  q<= data_in;
			end
endmodule

module dff_1(clock,reset_n,data_in,q);
		input clock,reset_n,data_in;
		output reg q;
		always@(posedge clock)
		   begin
			if(reset_n == 0) 
				  q <= 1'b1; 
			else
				  q<= data_in;
			end
endmodule



module random(clock,reset_n,q);
		input clock,reset_n;
		output [3:0] q;
		
		dff_0 m1(clock,reset_n,q[2] ^ q[3],q[0]);
		dff_1 m2(clock,reset_n,q[0],q[1]);
		dff_1 m3(clock,reset_n,q[1],q[2]);
		dff_1 m4(clock,reset_n,q[2],q[3]);
endmodule

module datapath1(x,y,colour,ld_c,clock,reset_n,enable,X,Y,Colour);
	input reset_n,enable,clock,ld_c;
	input [7:0] x,y;
	input [2:0] colour;
	output[7:0] X;
	output [7:0] Y;
	output [2:0] Colour;
	reg [7:0] x1,y1,co1;
	
	wire [3:0] c1;
	wire [6:0] c2;
	
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
	x_1_counter m1(clock,reset_n,enable,c1);
	assign enable_1 = (c1==  4'd10) ? 1 : 0;
	y_1_counter m3(4'd12,clock,reset_n,enable_1,c2);
	assign X = x1 + c1;
	assign Y = y1 + c2;
	assign Colour = co1;
endmodule


module x_1_counter(clock,reset_n,enable,q);
	input clock,reset_n,enable;
	output reg [3:0] q;
	
	always @(posedge clock)
	begin
		if(reset_n == 1'b0)
			q <= 4'd0;
		else if(enable == 1'b1)
		begin
		  if(q == 4'd10)
			  q <= 4'd0;
		  else
			  q <= q + 1'b1;
		end
   end
endmodule

module y_1_counter(random,clock,reset_n,enable,q);
	input clock,reset_n,enable;
	input [3:0] random;
	output reg [6:0] q;
	
	reg [6:0] limit;  
	
	always @(*)
	begin
		if( random < 4'd6 )
			limit = 7'd30;
		else if ( random < 4'd11 )
			limit = 7'd60;
		else if ( random < 4'd15 )
			limit = 7'd90;
	end
	
	always @(posedge clock)
	begin
		if(reset_n == 1'b0)
			q <= 7'd0;
		else if(enable == 1'b1)
		begin
		  if(q == limit)
			  q <= 7'd0;
		  else
			  q <= q + 1'b1;
		end
   end
endmodule
