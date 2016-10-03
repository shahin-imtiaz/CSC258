module mux7to1(SW, LEDR);
	input [9:0] SW;
	output [1:0]LEDR;
	reg m;
	
	always @(*)
	begin
		case(SW[9:7])
			3'b000: m = SW[0];
			3'b001: m = SW[1];
			3'b010: m = SW[2];
			3'b011: m = SW[3];
			3'b100: m = SW[4];
			3'b101: m = SW[5];
			3'b110: m = SW[6];
			default: m = SW[7];
		endcase
	end
	assign LEDR[0]= m;
	
endmodule
