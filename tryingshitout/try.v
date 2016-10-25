module try(enable, load, par_load, asr_n, clk, out);
	input enable, par_load, asr_n, clk;
	input [9:0] load;
	output reg out;
	
	reg [9:0] q;
	
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
