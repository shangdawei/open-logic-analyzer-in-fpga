module TestOutput(ain,bin,Allout);

	input ain;
	input bin;
	output reg [14:0] Allout;

	always begin
		Allout[0]=bin;
		Allout[1]=ain;
		Allout[2]=ain ^ bin;
		Allout[3]=ain | bin;
	end

	always @(posedge ain)begin
		Allout[6:4]=Allout[6:4]+1;
	end
	
	always begin
		case (Allout[6:4])
			3'b000:Allout[14:7]=8'b00000001;
			3'b001:Allout[14:7]=8'b00000010;
			3'b010:Allout[14:7]=8'b00000100;
			3'b011:Allout[14:7]=8'b00001000;
			
			3'b100:Allout[14:7]=8'b00010000;
			3'b101:Allout[14:7]=8'b00100000;
			3'b110:Allout[14:7]=8'b01000000;
			default:Allout[14:7]=8'b10000000;	
		endcase
	end

endmodule
